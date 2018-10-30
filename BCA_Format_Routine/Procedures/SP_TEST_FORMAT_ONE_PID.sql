CREATE OR ALTER PROCEDURE dbo.SP_TEST_FORMAT_ONE_PID
(
	@p_Type			VARCHAR(10) = 'SIMPLE'
)
AS
BEGIN	
	DECLARE	    @p_folio				VARCHAR(50),  
				@p_PID_List				VARCHAR(max)

	IF @p_Type = 'SIMPLE'
	BEGIN
		SELECT TOP 1	@p_folio =		A.[Folio_Number],
						@p_PID_List =	(STUFF((SELECT '; ' + CAST(B.[PID] AS VARCHAR(50))
												  FROM [dbo].[FolioPID] AS B
												  WHERE B.[Folio_Number] = A.[Folio_Number]
												  ORDER BY B.[PID]
												  FOR XML PATH('')), 1, 1, ''))
			FROM [dbo].[FolioPID] AS A
			GROUP BY A.[Folio_Number]
			ORDER BY 1
	END

	SELECT [dbo].[FNC_FORMAT_Property_ID_List](@p_folio, @p_PID_List)
	IF @@ERROR <> 0
	BEGIN
		EXEC [dbo].[SP_LOG_ERROR](SELECT ERROR_MESSAGE(),ERROR_STATE(), ERROR_SEVERITY())
		RETURN NULL
	END

	RETURN 0
END
