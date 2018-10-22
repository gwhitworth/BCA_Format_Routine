/*********************************************************************************************************************
Function: FNC_SET_POSTAL

Purpose: Only for USA and Canada

--Parameter:

Return/result: postal code or null for internal country

Assumption: none

Modified History:
Version     Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0         Nov 2018    original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_SET_POSTAL]
(
	@p_country VARCHAR, 
	@p_postal_zip VARCHAR
)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @rtnPostal VARCHAR(20)
	IF @p_country IS NOT NULL
	BEGIN
		IF @p_country = '37' OR @p_country = '226'
		BEGIN
			IF @p_postal_zip IS NOT NULL
				SET @rtnPostal = [dbo].[CondStr](@p_postal_zip)
		END
		ELSE
			RETURN NULL;
	END
	RETURN @rtnPostal
END