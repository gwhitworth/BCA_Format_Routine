/*********************************************************************************************************************
Function: [dbo].[SP_TEST_FORMAT_Legal_Description_2]

Purpose: This proc is used for testing and debugging format address function

Parameter: None

Result: Loop through Leagal Descriptions and Set.
		This is for testing

Assumption: none

Modified History:
Version......Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0..........Nov 2018...... original build      Gerry Whitworth
*********************************************************************************************************************/
CREATE OR ALTER PROCEDURE [dbo].[SP_TEST_FORMAT_Legal_Description_2]
AS
BEGIN	
INSERT INTO [dbo].[LegalDescription]([LegalDescription])
SELECT --TOP 100
	(SELECT [dbo].[FNC_FORMAT_LEGAL]
				(	
				'324',  
				[A].[Parcel],  
				LEN([A].[Parcel]),
				[A].[Lot],  
				LEN([A].[Lot]),
				[A].[Strata_Lot_Number],  
				LEN([A].[Strata_Lot_Number]),
				[A].[Block_Number],  
				LEN([A].[Block_Number]),
				[A].[Sub_Block],  
				LEN([A].[Sub_Block]),  
				[A].[Plan_Number],  
				LEN([A].[Plan_Number]),  
				[A].[Suburban_Lot_Number],
				LEN([A].[Suburban_Lot_Number]),
				'??part_1 NOT FOUND??',
				'??part_2 NOT FOUND??',
				'??part_2 NOT FOUND??',
				'??part_4 NOT FOUND??',
				LEN('??part_1 NOT FOUND??'+'??part_2 NOT FOUND??'+'??part_3 NOT FOUND??'+'??part_4 NOT FOUND??'),
				[A].[District_Lot],
				LEN([A].[District_Lot]),
				'??legal_subdivision NOT FOUND??',  
				LEN('??legal_subdivision NOT FOUND??'),
				[A].[Section],  
				LEN([A].[Section]),  
				[A].[Township_Code],  
				LEN([A].[Township_Code]),  
				[A].[Range],  
				LEN([A].[Range]),  
				[A].[Meridian],  
				LEN([A].[Meridian]),  
				[A].[BCA_AO_Group],  
				LEN([A].[BCA_AO_Group]),
				[A].[Land_District_Code],  
				LEN([A].[Land_District_Code]),  
				[A].[Portion],  
				LEN([A].[Portion]),
				[A].[Exception_Plan],  
				LEN([A].[Exception_Plan]),
				[A].[Legal_Text],  
				LEN([A].[Legal_Text]),
				[A].[Air_Space_Parcel],  
				LEN([A].[Air_Space_Parcel]),
				[A].[Lease_Licence_Number],  
				LEN([A].[Lease_Licence_Number]),
				'??mf_num NOT FOUND??',  
				LEN('??mf_num NOT FOUND??'),
				'??mhr_num NOT FOUND??',
				LEN('??mhr_num NOT FOUND??'),
				'??bay_no NOT FOUND??',  
				LEN('??bay_no NOT FOUND??'),
				'??mobile_park_name NOT FOUND??',
				LEN('??mobile_park_name NOT FOUND??'),
				'??park_folio_id NOT FOUND??',
				LEN('??park_folio_id NOT FOUND??'),
				[A].[Pid],  
				[B].[Property_ID_List],  
				LEN([B].[Property_ID_List]),
				'??nts_block_num NOT FOUND??',
				LEN('??nts_block_num NOT FOUND??'),
				'??nts_exception NOT FOUND??',
				LEN('??nts_exception NOT FOUND??'),
				'??nts_map_num NOT FOUND??',
				LEN('??nts_map_num NOT FOUND??'),
				[A].[NTS_Quarter],
				LEN([A].[NTS_Quarter]),
				[A].NTS_Unit,  
				LEN([A].NTS_Unit),
				[A].[OGC_Project_Number],
				LEN([A].[OGC_Project_Number])
				)
	)
	FROM [dbo].[Parcel_2] AS [A]
		INNER JOIN (SELECT [A].dimParcel_SK, 
			            [A].[Folio_Number],
						(SELECT [dbo].[FNC_FORMAT_Property_ID_List](STUFF((SELECT '; ' + CAST(B.[PID] AS VARCHAR(50))
															FROM [dbo].[FolioPID] AS B
															WHERE B.[Folio_Number] = A.[Folio_Number]
															ORDER BY B.[PID]
															FOR XML PATH('')), 1, 1, ''))) AS [Property_ID_List]
					FROM [dbo].[ParcelFolioPID] AS [A]
					GROUP BY [A].dimParcel_SK,A.[Folio_Number]) AS [B] ON [A].dimParcel_SK = [B].dimParcel_SK

END
