DROP FUNCTION IF EXISTS [dbo].[FNC_PREPEND_DATA]
GO
/*********************************************************************************************************************
Function: FNC_PREPEND_DATA

Purpose: This function is to add the required info for the address line

Parameter: p_temp, p_prefix

Return/result: an address field for the address line if null, return null else
            return address field with prefix

Assumption: none

Modified History:
Version                      Date			Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0                          Nov 2018		original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_PREPEND_DATA]
(
	@p_temp		VARCHAR(500) = '', 
	@p_prefix	VARCHAR(500) = ''
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @rtnVal VARCHAR(255) = ''

	IF @p_temp IS NOT NULL
		SET @rtnVal = @p_prefix + upper(trim(dbo.CondStr(@p_temp)))
	ELSE
		SET @rtnVal = ''

	IF @@ERROR <> 0
		RETURN NULL

	RETURN @rtnVal
END;