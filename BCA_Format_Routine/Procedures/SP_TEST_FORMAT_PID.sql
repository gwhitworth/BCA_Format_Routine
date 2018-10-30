/*********************************************************************************************************************
Function: [dbo].[SP_TEST_FORMAT_PID]

Purpose: This proc is used for testing and debugging format PID

Parameter: None

Result: Loop through PIDs and Set.
		This is for testing

Assumption: none

Modified History:
Version......Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0..........Nov 2018...... original build      Gerry Whitworth
*********************************************************************************************************************/
CREATE OR ALTER PROCEDURE [dbo].[SP_TEST_FORMAT_PID]
AS
BEGIN	
	INSERT INTO [dbo].[FolioFormattedPID]([FolioNumber],[FormattedPID] )
	SELECT A.[Folio_Number],
		(SELECT [dbo].[FNC_FORMAT_Property_ID_List]([A].Folio_Number,STUFF((SELECT '; ' + CAST(B.[PID] AS VARCHAR(50))
											FROM [dbo].[FolioPID] AS B
											WHERE B.[Folio_Number] = A.[Folio_Number]
											ORDER BY B.[PID]
											FOR XML PATH('')), 1, 1, '')))
	FROM [dbo].[FolioPID] AS A
	GROUP BY A.[Folio_Number]
	ORDER BY 1
END
