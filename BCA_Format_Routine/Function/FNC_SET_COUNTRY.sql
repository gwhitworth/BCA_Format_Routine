DROP FUNCTION IF EXISTS [dbo].[FNC_SET_COUNTRY]
GO
/*********************************************************************************************************************
Function: FNC_SET_COUNTRY

Purpose: Find the internal country from lookup table by using country code

Parameter: p_country

Return/result: country name or null if not found

Assumption: None

Modified History:
Version                    Date				Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0                        Nov 2018			original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_SET_COUNTRY]
(
	@p_country VARCHAR(10)
)
RETURNS VARCHAR(30)
AS
BEGIN
	DECLARE @country VARCHAR(30)

	IF @p_country <> '37' --Kyrgyzstan
	BEGIN	
		SELECT @country = Country_Desc
			FROM dbo.dimCountryTbl
			WHERE Country_Code = @p_country
	END

	RETURN upper(trim(@country))
END