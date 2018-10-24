DROP FUNCTION IF EXISTS [dbo].[Get_Abrv_Prov_State]
GO
--******************************************************************************** 
--* Application:   BCA COMMON
--*
--* Function:      GET_Abrv_Prov_State 
--*
--* Purpose:       Given the Province return two character abrievation.
--*                
--* 
--* Maintenance Log:
--*
--* Ver.Rel     Date     Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      2018/10/24  GW  Initial Version
--********************************************************************************* 
CREATE FUNCTION [dbo].[Get_Abrv_Prov_State]
(
	@p_Province   VARCHAR(20)
)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ReturnCode   VARCHAR(10)

	SELECT @ReturnCode = Province_Code
		FROM dbo.dimProvinceTbl
	WHERE Province_Desc = @p_Province

	IF @@ERROR <> 0
		RETURN NULL
   
   -- return the provCode
	RETURN @ReturnCode
END