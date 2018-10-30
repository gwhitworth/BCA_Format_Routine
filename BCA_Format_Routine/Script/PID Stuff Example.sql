SELECT  A.[Folio_Number],
   STUFF((SELECT '; ' + CAST(B.[PID] AS VARCHAR(50))
          FROM [dbo].[FolioPID] AS B
          WHERE B.[Folio_Number] = A.[Folio_Number]
		  ORDER BY B.[PID]
          FOR XML PATH('')), 1, 1, '') [Property ID List]
FROM [dbo].[FolioPID] AS A
GROUP BY A.[Folio_Number]
ORDER BY 1