DROP FUNCTION IF EXISTS [dbo].[FNC_APPEND_LEGAL_DESCRIPTION]
GO
/*********************************************************************************************************************
Function: FNC_APPEND_LEGAL_DESCRIPTION

Purpose: This is a function to append the data field, prefix and separator.

Parameter: pv_temp, pv_separator, pv_prefix

Return/result: a data field with prefix and comma
            remark: null data field will return null
            
Assumption: None

Modified History: 
Version      Date       Purpose
---------------------------------------------------------------------------------------------------------------------
1.0         Nov 2018      original build


*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_APPEND_LEGAL_DESCRIPTION]
(
	@p_temp			VARCHAR(max), 
	@p_separator	VARCHAR(10),
    @p_prefix		VARCHAR(500), 
	@p_suffix		VARCHAR(500)
)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @RtnStr		VARCHAR(max) = ''

	IF @p_temp IS NOT NULL
	BEGIN
		SET @RtnStr = TRIM(CAST(@p_temp AS VARCHAR(max)))

		IF @p_prefix IS NOT NULL
			SET @RtnStr = @p_prefix + ' ' + UPPER(TRIM(@RtnStr))

		IF @p_suffix IS NOT NULL
			SET @RtnStr = @RtnStr + ' ' + @p_suffix
	
		IF @p_separator IS NOT NULL
			SET @RtnStr = TRIM(@RtnStr) + @p_separator + ' '
		
	END

	RETURN @RtnStr
END
