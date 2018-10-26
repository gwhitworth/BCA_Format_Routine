DROP FUNCTION IF EXISTS [dbo].[FORMAT_PID]
GO
--******************************************************************************** 
--* Application:   Data Clearing House 
--*
--* Function:      FORMAT_PID 
--*
--* Purpose:       Takes the unformatted numeric property ID and returns a string 
--*                in nnn-nnn-nnn format.  If the incoming property ID is null 
--*                then return null.  For all other error situations return the 
--*                incoming PID as a 9-character string with leading zeroes.
--* 
--* Maintenance Log:
--*
--* Ver.Rel     Date     Developer/Description 
--* -------  ----------  ---------------------------------------------------------
--* 1.0      2018/11/01  GW  Initial Version 
--********************************************************************************* 
CREATE FUNCTION [dbo].[FORMAT_PID]
(
	@p_pid VARCHAR(50)
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @Rtn		VARCHAR(50) = ''

   IF @p_pid IS NOT NULL
      SET @Rtn = SUBSTRING(TRIM(CAST(@p_pid AS VARCHAR(50))),1,3) + '-' +
				 SUBSTRING(TRIM(CAST(@p_pid AS VARCHAR(50))),4,3) + '-' +
				 SUBSTRING(TRIM(CAST(@p_pid AS VARCHAR(50))),7,3)

	RETURN TRIM(@Rtn)
END