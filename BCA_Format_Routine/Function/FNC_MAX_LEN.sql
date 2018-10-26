DROP FUNCTION IF EXISTS [dbo].[FNC_MAX_LEN]
GO
/*********************************************************************************************************************
Function: FNC_MAX-LEN

Purpose: This is a function to check if the field length greater than the constraint

Parameter: pv_temp (field content), pv_len, 
         

Return/result: > than the constraint, truncate the field until it fit in the cosntraint
            otherwise, return back the field
      
Assumption: The parameters are not null

Modified History: 
Version     Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0        Nov 2018    original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_MAX_LEN]
(
	@p_temp		VARCHAR(500), 
	@p_len		INT
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Rtn VARCHAR(500)

	IF LEN(TRIM(@p_temp)) > @p_len
	   SET @Rtn = SUBSTRING(@p_temp, 1, @p_len)
	ELSE
		SET @Rtn = TRIM(@p_temp)

	RETURN @Rtn
END
