DROP FUNCTION IF EXISTS [dbo].[Get_Country]
GO

--******************************************************************************** 
--* Application:   BCA COMMON
--*
--* Function:      Get_Country
--*
--* Purpose:       Given the Code return the country name.
--*                
--* 
--* Maintenance Log:
--*
--* Ver.Rel     Date     Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      2018/10/24  GW  Initial Version
--********************************************************************************* 
CREATE FUNCTION [dbo].[Get_Country]
(
	@p_CtrCode   VARCHAR(10)
)
RETURNS VARCHAR(60)
AS
BEGIN
	DECLARE @RtnCountry   VARCHAR(60)

	SELECT @RtnCountry = Country_Desc
		FROM dbo.dimCountryTbl
	WHERE dimCountry_BK = @p_CtrCode

	IF @@ERROR <> 0
		RETURN NULL

	RETURN @RtnCountry
END
