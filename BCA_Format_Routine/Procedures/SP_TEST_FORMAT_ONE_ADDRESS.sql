/*********************************************************************************************************************
Procedure: dbo.SP_TEST_FORMAT_ONE_ADDRESS

Purpose: This proc is used for testing and debugging one format address call

Parameter: None

Result: Loop through NameAddress table and Set.
		This is for testing

Assumption: none

Modified History:
Version......Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0..........Nov 2018...... original build      Gerry Whitworth
*********************************************************************************************************************/
CREATE OR ALTER PROCEDURE dbo.SP_TEST_FORMAT_ONE_ADDRESS
AS
BEGIN	
	DECLARE	@City				varchar(50),
			@Country			varchar(50),
			@Freeform_Address	varchar(500),
			@Directional		varchar(50),
			@Postal_zip			varchar(10),
			@Province_State		varchar(50),
			@Street_Name		varchar(50),
			@Street_Number		varchar(50),
			@Street_Type		varchar(50),
			@Unit_Number		varchar(50),
			@Address_Floor		varchar(50),
			@Address_CO			varchar(50),
			@Address_Attention	varchar(50),
			@Address_Site		varchar(50),
			@Address_Comp		varchar(50),
			@Address_Mod		varchar(50),
			@Address_Mod_Value	varchar(50),
			@Address_Dim		varchar(50),
			@Address_Dim_Value	varchar(50),
			@line_length		int,
			@Line_Number		int

	SELECT TOP 1
			@City = dimCity_BK,
			@Country = dimCountry_BK,
			@Freeform_Address = '',
			@Directional = dimStreetDirection_BK,
			@Postal_zip = Postal_Zip_Code,
			@Province_State = dimProvince_BK,
			@Street_Name = Address_Street_Name,
			@Street_Number = Street_Number,
			@Street_Type = dimStreetType_BK,
			@Unit_Number = Address_Unit,
			@Address_Floor = Floor_Number,
			@Address_CO = Care_Of,
			@Address_Attention = Attention,
			@Address_Site = [Site],
			@Address_Comp = Compartment,
			@Address_Mod = Delivery_Mode_Desc,
			@Address_Mod_Value = Delivery_mode_Value
	FROM [dbo].[NameAddress]

	SELECT [dbo].[FNC_FORMAT_ADDRESS](	@City,
										@Country,
										@Freeform_Address,
										@Directional,
										@Postal_zip,
										@Province_State,
										@Street_Name,
										@Street_Number,
										@Street_Type,
										@Unit_Number,
										@Address_Floor,
										@Address_CO	,
										@Address_Attention,
										@Address_Site,
										@Address_Comp,
										@Address_Mod,
										@Address_Mod_Value,
										'',
										'',
										2000,
										1
									)
	IF @@ERROR <> 0
	BEGIN
		EXEC [dbo].[SP_LOG_ERROR](SELECT ERROR_MESSAGE(),ERROR_STATE(), ERROR_SEVERITY())
		RETURN NULL
	END

	RETURN 0
END
