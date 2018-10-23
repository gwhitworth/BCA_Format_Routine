DROP FUNCTION IF EXISTS [dbo].[CondStr]
GO
--********************************************************************************
--* Application:   Roll Data
--*
--* Function:      CondStr
--*
--* Purpose:       Takes a string as input and returns the string trimmed without
--*                double spaces and upper cased.
--*
--* Maintenance Log:
--*
--* Ver.Rel     Date		Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      Nov 2018		GW  Initial Version
--*********************************************************************************
CREATE FUNCTION [dbo].[CondStr]
(
	@p_Str VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @rtnStr VARCHAR(500),
			@SpacesExist INT = 0

	IF @p_Str IS NULL
		RETURN NULL
	ELSE
	BEGIN
      --Remove leading, trailing and multipule spaces.
      SET @rtnStr = @p_Str
      SET @SpacesExist = CHARINDEX(@rtnStr, '  ');

      --Loop through and remove multipule spaces.
      WHILE 1 = 1
	  BEGIN
         SET @rtnStr = REPLACE(@rtnStr, '  ', ' ')
         SET @SpacesExist = CHARINDEX(@rtnStr, '  ')
		 IF @SpacesExist = 0
			BREAK;
	  END
	 END --ELSE
	RETURN TRIM(UPPER(@rtnStr))
END
