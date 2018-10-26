DROP FUNCTION IF EXISTS [dbo].[FNC_DISTRICT_DESC]
GO
/*********************************************************************************************************************
Function: FNC_DISTRICT_DESC

Purpose: This is a function is get the land district description from the look up table
       AO_U_Land_District
       
Parameter: pv_land_district

Return/result: description if found, else return null
            
Assumption: None

Modified History: 
Version    Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0       Nov 2018   original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_DISTRICT_DESC]
(
	@p_land_istrict_code VARCHAR(10)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Rtn		VARCHAR(500) = ''

	--IF @p_land_istrict_code IS NOT NULL
 --   BEGIN
	--	--SELECT @Rtn = [DESCRIPTION]
	--	--	FROM BCA_AO.AO_U_LAND_DISTRICT l
	--	--WHERE l.code = @p_land_istrict_code
	--END
	RETURN TRIM(@Rtn)
END