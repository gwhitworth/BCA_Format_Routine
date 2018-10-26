DROP FUNCTION IF EXISTS [dbo].[FNC_GET_PART]
GO
/*********************************************************************************************************************
Function: FNC_GET_PART

Purpose: This is a function is followed the formatted rule  of partn

Parameter: pv_partn

Return/result: if the part is not null and is 1 char, give out part with 1/4
            otherwise; give out part with 1/2
            
Assumption: None

Modified History: 
Version    Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0       June 2005   original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_GET_PART]
(
	@p_part VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Rtn VARCHAR(500) = ''

	IF @p_part IS NOT NULL
	BEGIN
		IF LEN(@p_part) = 1
			SET @Rtn = UPPER(@p_part) + '1/2'
		ELSE
			SET @Rtn = UPPER(@p_part) + '1/4'
	END

	RETURN @Rtn
END
