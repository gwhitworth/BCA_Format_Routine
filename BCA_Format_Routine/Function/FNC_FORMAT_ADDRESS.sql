DROP FUNCTION IF EXISTS [dbo].[FNC_FORMAT_ADDRESS]
GO
/*********************************************************************************************************************
Function: dbo.FNC_FORMAT_ADDRESS

Purpose: This is a common function to format owner address

Parameter:	@p_City, @p_Country, @p_Freeform_Address, @p_Directional,
			@p_Postal_zip, @p_Province_State, @p_Street_Name,
			@p_Street_Number, @p_Street_Type, @p_Unit_Number, @p_Address_Floor,
			@p_Address_CO, @p_Address_Attention, @p_Address_Site, @p_Address_Comp,
			@p_Address_Mod, @p_Address_Mod_Value, @p_Address_Dim, @p_Address_Dim_Value,
			@p_line_length,	@p_Line_Number

Return/result: Requested Address line

Assumption: none

Modified History:
Author.....................Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0........................Nov 2018......original build       Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_FORMAT_ADDRESS]
(
	@p_City					varchar(50),
	@p_Country				varchar(50),
	@p_Freeform_Address		varchar(500),
	@p_Directional			varchar(50) = '',
	@p_Postal_zip			varchar(10),
	@p_Province_State		varchar(50),
	@p_Street_Name			varchar(50) = '',
	@p_Street_Number		varchar(50) = '',
	@p_Street_Type			varchar(50) = '',
	@p_Unit_Number			varchar(50),
	@p_Address_Floor		varchar(50),
	@p_Address_CO			varchar(50),
	@p_Address_Attention	varchar(50),
	@p_Address_Site			varchar(50),
	@p_Address_Comp			varchar(50),
	@p_Address_Mod			varchar(50),
	@p_Address_Mod_Value	varchar(50),
	@p_Address_Dim			varchar(50),
	@p_Address_Dim_Value	varchar(50),
	@p_line_length			int,
	@p_Line_Number			int
)
RETURNS varchar(max)
AS
BEGIN
	-- freeform address
	DECLARE @Freeform_Table TABLE
	(
		RowID int not null primary key identity(1,1),
		AddressLine varchar(255)
	)
	DECLARE @RowsToProcess  int,
			@CurrentRow     int,
			@SelectCol1     varchar(255)

	DECLARE @rtnValue	varchar(max) = '',
			@address	varchar(500) = '',
			@addr1		varchar(255) = '',
			@addr2		varchar(255) = '',
			@addr3		varchar(255) = '',
			@addr4		varchar(255) = '',
			@addr5		varchar(255) = '',
			@overflow	varchar(255) = '',
			@tmpStr		varchar(500) = '',
			@tmpFreeF	varchar(255) = '',
			@CRLFExist  int = 0,
			@i			int = 0;

	SET @address = dbo.FNC_PREPEND_DATA(@p_Address_CO, 'C/O ')
	SET @address = dbo.FNC_APPEND_CRLF(@address, (dbo.FNC_PREPEND_DATA(@p_Address_Attention, 'ATTN ')))

	SET @addr1 = trim(@addr1 + dbo.FNC_APPEND_DATA(@p_Street_Number, ' ') +
					--dbo.FNC_APPEND_DATA(@p_Pre_Directional, ' ') +
					dbo.FNC_APPEND_DATA(@p_Street_Name, ' ') +
					dbo.FNC_APPEND_DATA(@p_street_type, ' ') +
					--dbo.FNC_APPEND_DATA(@p_post_directional, ' '))
					dbo.FNC_APPEND_DATA(@p_directional, ' '))
    
	--If this isn't a US address
	IF (@p_country <> '226')  
	BEGIN
		--if unit number won't fit on street address line
		IF ((LEN(@p_unit_number) + 1 + LEN(@Addr1)) > @p_line_length)
			SET @overflow = dbo.FNC_PREPEND_DATA(@p_unit_number, 'UNIT ');
		ELSE  --fix, append the unit # at the start of address line
			SET @addr1 = dbo.FNC_APPEND_DATA(@p_unit_number, '-') + @addr1;
	END
	ELSE--USA country, if unit # not fix
	BEGIN
        IF ((LEN(@addr1) + 3 + LEN(@p_unit_number)) > @p_line_length)
			SET @overflow = dbo.FNC_PREPEND_DATA(@p_unit_number, '#');
	    ELSE
			SET @addr1 = @addr1 + dbo.FNC_PREPEND_DATA(@p_unit_number, ' #');
	END

	--check floor for overflow
	IF ((LEN(@addr1) + 4 + LEN(@p_address_floor)) > @p_line_length)
		SET @overflow = trim(@overflow +  ' ' + dbo.FNC_APPEND_DATA((dbo.FNC_PREPEND_DATA(@p_address_floor, 'FLR ')), ' '));
	ELSE
		SET @addr1 = trim(@addr1 + ' ' + dbo.FNC_APPEND_DATA((dbo.FNC_PREPEND_DATA(@p_address_floor, 'FLR ')), ' '));

	SET @addr2 =	trim(@addr2 + dbo.FNC_APPEND_DATA((dbo.FNC_PREPEND_DATA(@p_address_site, 'SITE ')), ' ')
					+ dbo.FNC_APPEND_DATA((dbo.FNC_PREPEND_DATA(@p_address_comp, 'COMP ')), ' '));

	SET @addr3 =	trim(@addr3 + dbo.FNC_APPEND_DATA(@p_address_mod, ' ')
						+ dbo.FNC_APPEND_DATA(@p_address_mod_value, ' ')
						+ dbo.FNC_APPEND_DATA(@p_address_dim, ' ')
						+ dbo.FNC_APPEND_DATA(@p_address_dim_value, ' '));

	SET @addr4 =	trim(@addr4 + dbo.FNC_APPEND_DATA(@p_city, ' ')
						+ dbo.FNC_APPEND_DATA(dbo.FNC_SET_PROVINCE(@p_province_state), '     ')
						+ dbo.FNC_APPEND_DATA(@p_postal_zip, ' '));

	SET @addr5 =	trim(@addr5 + dbo.FNC_APPEND_DATA(dbo.FNC_SET_COUNTRY(@p_country), ' '));

  --combine all the address lines order into one line with carry return and line feed between them
	IF @p_freeform_address IS NOT NULL
	BEGIN
		-- check for 1st carriage return within the freeform address
		SET @tmpStr = dbo.CLEAN_CRLF(@p_freeform_address);
		SET @CRLFExist = CHARINDEX(@tmpStr, CHAR(13) + CHAR(10));

		-- No carriage return found in the string
		IF @CRLFExist = 0
		BEGIN
			-- add code to handle long freeform address
			IF LEN(@tmpStr) > @p_line_length
			BEGIN
				SET @tmpStr = '';
				WHILE @i <= 5
				BEGIN
					INSERT INTO @Freeform_Table (AddressLine) VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
					SET @i = @i + 1
				END --LOOP
			END --IF
			ELSE
			BEGIN
				SET @tmpStr = ''
				INSERT INTO @Freeform_Table (AddressLine) VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
				SET @i = 2
				WHILE @i <= 5
				BEGIN
					INSERT INTO @Freeform_Table (AddressLine) VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
					SET @i = @i + 1
				END --WHILE
			END --ELSE
		END  --IF
	END --IF
	ELSE   -- carriage return embedded within the string
	BEGIN
		WHILE @i <= 5
		BEGIN
			IF @CRLFExist > 0
			BEGIN
				IF @CRLFExist > @p_line_length + 1
				BEGIN
					SET @tmpFreeF = dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, 1)
					INSERT INTO @Freeform_Table (AddressLine) VALUES(@tmpFreeF)
					--INSERT INTO @Freeform_Table (AddressLine) VALUES('JUNK')
					SET @tmpStr = SUBSTRING(@tmpStr, LEN(@tmpFreeF)+1,LEN(@tmpStr))
					SET @tmpStr = dbo.clean_crlf(@tmpStr)
					SET @CRLFExist = CHARINDEX(@tmpStr, CHAR(13) + CHAR(10))
				END --IF
				ELSE
				BEGIN
					INSERT INTO @Freeform_Table (AddressLine) VALUES(SUBSTRING(@tmpStr, 1, @CRLFExist-1))
					--INSERT INTO @Freeform_Table (AddressLine) VALUES('JUNK2')
					SET @tmpStr		= SUBSTRING(@tmpStr, @CRLFExist+2, LEN(@tmpStr))
					SET @CRLFExist	= CHARINDEX(@tmpStr, CHAR(13) + CHAR(10))
				END --ELSE
			END --IF
			SET @i = @i + 1
		END --WHILE
	END -- ELSE **1st carriage return

	SELECT @RowsToProcess = COUNT(*) FROM @Freeform_Table
	SET @CurrentRow = 0
	WHILE @CurrentRow < @RowsToProcess
	BEGIN
		SET @CurrentRow = @CurrentRow + 1
		SELECT 
			@SelectCol1 = AddressLine
			FROM @Freeform_Table
			WHERE RowID = @CurrentRow
		IF ((@SelectCol1 <> '') OR LEN(@SelectCol1) > 0)
			SET @address = dbo.FNC_APPEND_CRLF(@address, @SelectCol1);
	END --WHILE

	SET @address = dbo.FNC_APPEND_CRLF(@address, @addr1)
	SET @address = dbo.FNC_APPEND_CRLF(@address, @addr2)
	SET @address = dbo.FNC_APPEND_CRLF(@address, @addr3)
	--in case the end of freeform address having crlf (i.e. double up in the address line), so clean out the duplicated crlf
	SET @address = dbo.CLEAN_CRLF(@address)

	IF (@addr4 IS NOT NULL AND @P_CITY IS NULL AND @P_PROVINCE_STATE IS NULL AND @P_POSTAL_ZIP IS NOT NULL)
		SET @address = @address + '     ' + @addr4
	ELSE IF @addr4 IS NOT NULL
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr4)
	ELSE
		SET @address = TRIM(@address);

	SET @address = dbo.FNC_APPEND_CRLF(@address, @addr5)

	--overflow will be displayed at the end of freeform
	SET @address = dbo.FNC_APPEND_CRLF(@address, @overflow)

	--in case if crlf at the start of address line
	IF SUBSTRING(@address, 1, 1) = CHAR(13) OR SUBSTRING(@address, 1, 1) = CHAR(10)
		SET @address = SUBSTRING(@address, 2, LEN(@address));

	IF SUBSTRING(@address, 1, 1) = CHAR(10) OR SUBSTRING(@address, 1, 1) = CHAR(13)
		SET @address = SUBSTRING(@address, 2, LEN(@address));
    ELSE--fixed from addr
	BEGIN
		SET @address = dbo.FNC_APPEND_CRLF(@address, @overflow);
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr1);
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr2);
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr3);
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr4);
		SET @address = dbo.FNC_APPEND_CRLF(@address, @addr5);
	END --ELSE

	--if pv_line_number is null or 0 return the whole address within length
    IF @p_line_number IS NULL OR @p_line_number = 0  
		SET @rtnValue = UPPER(TRIM(dbo.FNC_CHECK_LEN(@address, @p_line_length)))
    ELSE --return the line of addr according to the line number
      SET @rtnValue = UPPER(TRIM(dbo.FNC_GET_ADDRESS_LINE(@address, @p_line_length, @p_line_number)))

	IF @@ERROR <> 0
	BEGIN
		RETURN NULL
	END

	RETURN @rtnValue
END