DROP FUNCTION IF EXISTS [dbo].[Format_Roll_Owner_Addr]
GO
--********************************************************************************
--* Application:   Roll Data
--*
--* Function:      Format_Roll_Owner_Addr
--*
--* Purpose:       Takes the City, Country, FreeForm_Address, Post_Direction,
--*                Pre_Direction, Postal_Zip, Province_State, Street_Name,
--*                Street_Number, Street_Type, Unit_Number, @p_Line_Length, Line_Number
--*                and Delivery_Method as input.and returns a formatted address.
--*
--* Maintenance Log:
--*
--* Ver.Rel     Date     Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      2018/10/24  GW  Initial Version
--*********************************************************************************
CREATE FUNCTION [dbo].[Format_Roll_Owner_Addr]
(
	@p_Freeform_Address		VARCHAR(500),
	@p_Unit_Number			VARCHAR(20),
	@p_Street_Number		VARCHAR(20),
	@p_Pre_Directional		VARCHAR(10),
	@p_Street_Name			VARCHAR(50),
	@p_Street_Type			VARCHAR(20),
	@p_Post_Directional		VARCHAR(10),
	@p_City					VARCHAR(50),
	@p_Province_State		VARCHAR(10),
	@p_Postal_Zip			VARCHAR(10),
	@p_Country				VARCHAR(20),
	@p_Line_Length			INTEGER = 0,
	@p_Line_Number			INTEGER = 0
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @FreeForm_Addr		VARCHAR(256),
			@Unit_No			VARCHAR(8),
			@Strt_No			VARCHAR(8),
			@Strt_Name			VARCHAR(30),
			@Post_Dir			VARCHAR(10),
			@Pre_Dir			VARCHAR(10),
			@Strt_Type			VARCHAR(10),
			@City				VARCHAR(50),
			@Province			VARCHAR(10),
			@Country			VARCHAR(10),
			@Post_Zip			VARCHAR(11),
			@FreeForm_1			VARCHAR(256),
			@FreeForm_2			VARCHAR(256),
			@Address			VARCHAR(256),
			@City_Prov			VARCHAR(256),
			@Int_Country		VARCHAR(256),
			@ReturnLine			VARCHAR(256),
			@Line_Len			INTEGER = 0,
			@Line_No			INTEGER = 0,
			@Linefeed			INTEGER = 0,
			@LastStr			INTEGER = 0,
			@EndStr				INTEGER = 0

	SET @Line_Len = @p_Line_Length
	IF @p_Freeform_Address IS NOT NULL
	BEGIN
		SET @FreeForm_Addr = dbo.dbo.CondStr(@p_Freeform_Address)
		SET @Linefeed = CHARINDEX(CHAR(10), @FreeForm_Addr)
		IF @Linefeed > 0
		BEGIN
			IF @Linefeed > @Line_Len
			BEGIN
				SET @FreeForm_1 = SUBSTRING(@FreeForm_Addr, 1, @Line_Len)
				SET @LastStr = @Linefeed + 2
			END
		END
		ELSE
		BEGIN
			SET @FreeForm_1 = SUBSTRING(@FreeForm_Addr, 1, (@Linefeed - 2))
			SET @LastStr = @Linefeed + 2
		END
         
		SET @Linefeed = CHARINDEX(@FreeForm_Addr, CHAR(10), @Linefeed)
		SET @EndStr = CHARINDEX(@FreeForm_Addr, CHAR(10), @Linefeed)
		IF @Linefeed > 0
		BEGIN
			IF @Linefeed > @Line_Len
				SET @FreeForm_2 = SUBSTRING(@FreeForm_Addr, @LastStr, @Line_Len)
			ELSE
				SET @FreeForm_2 = SUBSTRING(@FreeForm_Addr, @LastStr, (@EndStr - @LastStr - 1))
		END
	END
	ELSE
		SET @FreeForm_1 = SUBSTRING(@FreeForm_Addr, 1, @Line_Len)

	--Remove leading and trailing spaces.
	IF @p_Unit_Number IS NOT NULL
	BEGIN
		SET @Unit_No = dbo.CondStr(@p_Unit_Number)
		SET @Address = @Unit_No + ' - '
	END

   --Remove leading and trailing spaces.
	IF @p_Street_Number IS NOT NULL
	BEGIN
		SET @Strt_No = dbo.CondStr(@p_Street_Number)
		SET @Address = @Address + @Strt_No + ' '
	END

	--Remove leading and trailing spaces.
	IF @p_Pre_Directional IS NOT NULL
	BEGIN
		SET @Pre_Dir = dbo.CondStr(@p_Pre_Directional)
		SET @Address = @Address + @Pre_Dir + ' '
	END

	--Remove leading and trailing spaces.
	IF @p_Street_Name IS NOT NULL
	BEGIN
		SET @Strt_Name = dbo.CondStr(@p_Street_Name)
		SET @Address = @Address + @Strt_Name + ' '
	END

	--Remove leading and trailing spaces.
	IF @p_Street_Type IS NOT NULL
	BEGIN
		SET @Strt_Type = dbo.CondStr(@p_Street_Type)
		SET @Address = @Address + @Strt_Type
	END

	--Remove leading and trailing spaces.
	IF @p_Post_Directional IS NOT NULL
	BEGIN
		SET @Post_Dir  = dbo.CondStr(@p_Post_Directional)
		SET @Address = ' ' + @Address + ' ' + @Post_Dir
	END

	--Remove leading and trailing spaces.
	IF @p_City IS NOT NULL
	BEGIN
		SET  @City = dbo.CondStr(@p_City)
		SET @City_Prov = @City + ' '
	END

	--Remove leading and trailing spaces.
	IF @p_Province_State IS NOT NULL
	BEGIN
		SET @Province = dbo.CondStr(@p_Province_State)
		IF LEN(@Province) > 2
			SET @City_Prov = @City_Prov + dbo.Get_Abrv_Prov_State(@Province)
		ELSE
			SET @City_Prov = @City_Prov + @Province
	END

	--Remove leading and trailing spaces.
	IF @p_Country IS NOT NULL
	BEGIN
		SET @Country = @p_Country
		IF @Country = '37' OR @Country = '226'
		BEGIN
			--Remove leading and trailing spaces.
			IF @p_Postal_Zip IS NOT NULL
			BEGIN
				SET @Post_Zip = dbo.CondStr(@p_Postal_Zip)
				SET @City_Prov = @City_Prov + '  ' + @Post_Zip
			END
		END
		IF @Country <> '37'
		BEGIN
			IF @Country = '226'
				SET @Int_Country = 'USA'
			ELSE
				SET @Int_Country = dbo.Get_Country(@Country)
		END
	END

	SET @ReturnLine = ''
	IF @p_Line_Number = 1
	BEGIN
		IF @FreeForm_1 IS NOT NULL
			SET @ReturnLine = @FreeForm_1
		ELSE
			SET @ReturnLine = @Address
	END
	ELSE IF @p_Line_Number = 2
	BEGIN
		IF @FreeForm_1 IS NOT NULL
		BEGIN
			IF @FreeForm_2 IS NOT NULL
				SET @ReturnLine = @FreeForm_2
			ELSE
				SET @ReturnLine = @Address
		END
		ELSE
			SET @ReturnLine = @City_Prov
	END
	ELSE IF @p_Line_Number = 3
	BEGIN
		IF @FreeForm_1 IS NOT NULL
		BEGIN
			IF @FreeForm_2 IS NOT NULL
				SET @ReturnLine = @Address
			ELSE
				SET @ReturnLine = @City_Prov
		END	
		ELSE
			SET @ReturnLine = @Int_Country
	END
	ELSE IF @p_Line_Number = 4
	BEGIN
		IF @FreeForm_1 IS NOT NULL
		BEGIN
			IF @FreeForm_2 IS NOT NULL
				SET @ReturnLine = @City_Prov
			ELSE
				SET @ReturnLine = @Int_Country
		END
	END
	ELSE IF @p_Line_Number = 5
	BEGIN
		IF @FreeForm_1 IS NOT NULL
		BEGIN
			IF @FreeForm_2 IS NOT NULL
				SET @ReturnLine = @Int_Country
		END
	END

	RETURN @ReturnLine
END
