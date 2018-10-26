/*********************************************************************************************************************
Function: [dbo].[SP_TEST_FORMAT_ADDRESS]

Purpose: This proc is used for testing and debugging format address function

Parameter: None

Result: Loop through NameAddress table and Set.
		This is for testing

Assumption: none

Modified History:
Version......Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0..........Nov 2018...... original build      Gerry Whitworth
*********************************************************************************************************************/
CREATE OR ALTER PROCEDURE [dbo].[SP_TEST_FORMAT_ADDRESS]
AS
BEGIN	
INSERT INTO [dbo].[NAME_ADDRESS_LINES_TEST]
           ([ADRS_LINE1]
           ,[ADRS_LINE2]
           ,[ADRS_LINE3]
           ,[ADRS_LINE4]
           ,[ADRS_LINE5])
SELECT TOP 1
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[TMP].dimCity_BK,[TMP].dimCountry_BK,NULL,[TMP].dimStreetDirection_BK,[TMP].Postal_Zip_Code,[TMP].dimProvince_BK,
										[TMP].Address_Street_Name,[TMP].Street_Number,[TMP].dimStreetType_BK,[TMP].Address_Unit,[TMP].Floor_Number,
										[TMP].Care_Of,[TMP].Attention,[TMP].[Site], [TMP].Compartment,[TMP].Delivery_Mode_Desc,
										[TMP].Delivery_Mode_Value,'','',50,1)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[TMP].dimCity_BK,[TMP].dimCountry_BK,NULL,[TMP].dimStreetDirection_BK,[TMP].Postal_Zip_Code,[TMP].dimProvince_BK,
										[TMP].Address_Street_Name,[TMP].Street_Number,[TMP].dimStreetType_BK,[TMP].Address_Unit,[TMP].Floor_Number,
										[TMP].Care_Of,[TMP].Attention,[TMP].[Site], [TMP].Compartment,[TMP].Delivery_Mode_Desc,
										[TMP].Delivery_Mode_Value,'','',50,2)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[TMP].dimCity_BK,[TMP].dimCountry_BK,NULL,[TMP].dimStreetDirection_BK,[TMP].Postal_Zip_Code,[TMP].dimProvince_BK,
										[TMP].Address_Street_Name,[TMP].Street_Number,[TMP].dimStreetType_BK,[TMP].Address_Unit,[TMP].Floor_Number,
										[TMP].Care_Of,[TMP].Attention,[TMP].[Site], [TMP].Compartment,[TMP].Delivery_Mode_Desc,
										[TMP].Delivery_Mode_Value,'','',50,3)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[TMP].dimCity_BK,[TMP].dimCountry_BK,NULL,[TMP].dimStreetDirection_BK,[TMP].Postal_Zip_Code,[TMP].dimProvince_BK,
										[TMP].Address_Street_Name,[TMP].Street_Number,[TMP].dimStreetType_BK,[TMP].Address_Unit,[TMP].Floor_Number,
										[TMP].Care_Of,[TMP].Attention,[TMP].[Site], [TMP].Compartment,[TMP].Delivery_Mode_Desc,
										[TMP].Delivery_Mode_Value,'','',50,4)
	),
	(SELECT [dbo].[FNC_FORMAT_ADDRESS](	[TMP].dimCity_BK,[TMP].dimCountry_BK,NULL,[TMP].dimStreetDirection_BK,[TMP].Postal_Zip_Code,[TMP].dimProvince_BK,
										[TMP].Address_Street_Name,[TMP].Street_Number,[TMP].dimStreetType_BK,[TMP].Address_Unit,[TMP].Floor_Number,
										[TMP].Care_Of,[TMP].Attention,[TMP].[Site], [TMP].Compartment,[TMP].Delivery_Mode_Desc,
										[TMP].Delivery_Mode_Value,'','',50,5)
	)
FROM [dbo].[NameAddress] AS [TMP]

END
