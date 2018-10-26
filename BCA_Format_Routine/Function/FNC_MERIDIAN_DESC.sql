DROP FUNCTION IF EXISTS [dbo].[FNC_MERIDIAN_DESC]
GO
/*********************************************************************************************************************
Function: FNC_MERIDIAN_DESC

Purpose: This is a function is get the meridian description from the look up table
       AO_U_Meridian 
       
Parameter: p_meridian_code

Return/result: description if found, else return null
            
Assumption: None 

Modified History: 
Version    Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0       Nov 2018   original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_MERIDIAN_DESC]
(
	@p_meridian_code VARCHAR(10)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Rtn		VARCHAR(500) = ''

	--IF @p_meridian_code IS NOT NULL
 --   BEGIN
	--	SELECT @Rtn = DESCRIPTION
	--		FROM BCA_AO.AO_U_MERIDIAN l
	--	WHERE  l.code = @p_meridian_code;
	--END
	RETURN TRIM(@Rtn)
END