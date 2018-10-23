DROP FUNCTION IF EXISTS [dbo].[FNC_SET_PROVINCE]
GO
/*********************************************************************************************************************
Function: FNC_SET_PROVINCE

Purpose: This is to get the province short from by using common function Get_Abrv_Prov_State

Parameter: p_province_state

Return/result: return the value of the table or null if not found

Assumption: The parameter of park_folio_id has been formated.

Modified History:
Version                     Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0							Nov 2018    original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_SET_PROVINCE]
(
	@p_province_state VARCHAR
)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @rtnProvAbbr VARCHAR(10)
	IF @p_province_state IS NOT NULL
	BEGIN
		SET @rtnProvAbbr = TRIM(REPLACE(@p_province_state, '  ', ' '));
		IF LEN(TRIM(@rtnProvAbbr)) > 2
		BEGIN
			SELECT @rtnProvAbbr = Province_Code
				FROM dbo.dimProvinceTbl
				WHERE Province_Desc = TRIM(@p_province_state)
		END
		ELSE
			SET @rtnProvAbbr = @p_province_state
	END
	RETURN(UPPER(TRIM(@rtnProvAbbr)));
END
