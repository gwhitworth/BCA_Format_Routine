DROP FUNCTION IF EXISTS [dbo].[FNC_FORMAT_ADDRESS]
GO
/*********************************************************************************************************************
Function: dbo.FNC_FORMAT_ADDRESS

Purpose: This is a common function to format owner address

Parameter:

Return/result: an address line

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
	@p_Post_Directional		varchar(50),
	@p_Postal_zip			varchar(10),
	@p_Pre_Directional		varchar(50),
	@p_Province_State		varchar(50),
	@p_Street_Name			varchar(50),
	@p_Street_Number		varchar(50),
	@p_Street_Type			varchar(50),
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
	@p_line_length			varchar(50),
	@p_Line_Number			varchar(50)
)
RETURNS varchar(max)
AS
BEGIN
	-- freeform address
	DECLARE @Freeform_list TABLE
	(
		AddressLine varchar(255)
	)
	DECLARE @rtnValue	varchar(max),
			@addr1		varchar(255),
			@addr2		varchar(255),
			@addr3		varchar(255),
			@addr4		varchar(255),
			@addr5		varchar(255),
			@address	varchar(255),
			@overflow	varchar(255),
			@tmpStr		varchar(500),
			@CRLFExist  int = 0,
			@tmpFreeF	varchar(255),
			@i			int = 0;


	SET @rtnValue = ''
	SET @address = dbo.FNC_PREPEND_DATA(@p_Address_CO, 'C/O ')
	SET @address = dbo.FNC_APPEND_CRLF(@address, (dbo.FNC_PREPEND_DATA(@p_Address_Attention, 'ATTN ')))

	SET @addr1 = trim(@addr1 + dbo.FNC_APPEND_DATA(@p_Street_Number, ' ') +
					dbo.FNC_APPEND_DATA(@p_Pre_Directional, ' ') +
					dbo.FNC_APPEND_DATA(@p_Street_Name, ' ') +
					dbo.FNC_APPEND_DATA(@p_street_type, ' ') +
					dbo.FNC_APPEND_DATA(@p_post_directional, ' '))
    
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
					INSERT INTO @Freeform_list VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
				END --LOOP
			END --IF
			ELSE
			BEGIN
				SET @tmpStr = ''
				INSERT INTO @Freeform_list VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
				SET @i = 2
				WHILE @i <= 5
				BEGIN
					INSERT INTO @Freeform_list VALUES(dbo.GET_FORMAT_LINE(@tmpStr, @p_line_length, @i))
				END --LOOP
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
					INSERT INTO @Freeform_list VALUES(@tmpFreeF)
					SET @tmpStr = SUBSTRING(@tmpStr, LEN(@tmpFreeF)+1,LEN(@tmpStr))
					SET @tmpStr = dbo.clean_crlf(@tmpStr)
					SET @CRLFExist = CHARINDEX(@tmpStr, CHAR(13) + CHAR(10))
				END --IF
				ELSE
				BEGIN
					INSERT INTO @Freeform_list VALUES(SUBSTRING(@tmpStr, 1, @CRLFExist-1))
					SET @tmpStr		= SUBSTRING(@tmpStr, @CRLFExist+2, LEN(@tmpStr))
					SET @CRLFExist	= CHARINDEX(@tmpStr, CHAR(13) + CHAR(10))
				END --ELSE
			END --IF
		END --LOOP
	END -- 1st carriage return
	RETURN @rtnValue
END