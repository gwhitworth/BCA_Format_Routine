DROP FUNCTION IF EXISTS [dbo].[FNC_APPEND_DATA]
GO
/*********************************************************************************************************************
Function: FNC_APPEND_DATA

Purpose: This function is to add the required info for the address line

Parameter: p_temp, p_suffix

Return/result: an address field for the address line if null, return null else
            return address field with suffix ' ' or '-''

Assumption: none

Modified History:
Version		Date			Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0			Nov 2018		original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_APPEND_DATA]
(
	@p_temp		VARCHAR(500), 
	@p_suffix	VARCHAR(500)
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @rtnVal VARCHAR(255)
	IF @p_temp IS NOT NULL
	   SET @rtnVal = upper(trim(@p_temp)) + @p_suffix;
	ELSE
	   SET @rtnVal = NULL

	IF @@ERROR <> 0
		RETURN NULL

	RETURN @rtnVal	
END