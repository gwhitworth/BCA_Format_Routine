--DROP FUNCTION IF EXISTS [dbo].[FNC_APPEND_CRLF]
--GO
/*********************************************************************************************************************
Function: FNC_APPEND_CRLF

Purpose: This function is to add the required info for the address line

Parameter: p_temp, p_source

Return/result: an stored field concantenate with crlf with another source of data

Assumption: none

Modified History:
Version                      Date			Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0                          Nov 2018		original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_APPEND_CRLF]
(
	@p_temp		VARCHAR, 
	@p_source	VARCHAR
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @rtnVal VARCHAR(500)
	IF @p_temp IS NOT NULL AND @p_source IS NOT NULL
		   SET @rtnVal = @p_temp + CHAR(13) + CHAR(10) + @p_source
	ELSE
		BEGIN
		   IF @p_temp IS NULL AND @p_source IS NOT NULL
				SET @rtnVal = @p_source
		   ELSE IF @p_temp IS NOT NULL AND @p_source IS NULL
				SET @rtnVal = @p_temp
		   ELSE
				SET @rtnVal = NULL
		END
		IF @@ERROR <> 0
			RETURN (NULL);

	RETURN @rtnVal	
END