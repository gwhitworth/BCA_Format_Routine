DROP FUNCTION IF EXISTS [dbo].[CLEAN_CRLF]
GO
--********************************************************************************
--* Application:   Roll Data
--*
--* Function:      CLEAN_CRLF
--*
--* Purpose:       Takes a string as input and returns the string without leading
--*                or trailing CRLF.  Also duplicate CRLFs are replace with single
--*                ones.  A string length of up to 2000 can be handled
--*
--* Maintenance Log:
--*
--* Ver.Rel     Date		Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      Nov 2018		GW  Initial Version
--*********************************************************************************
CREATE FUNCTION [dbo].[CLEAN_CRLF]
(
	@p_Str VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @rtnStr VARCHAR(500),
			@CRLFExist INT = 0

	IF @p_Str IS NULL
		RETURN NULL;
	ELSE
	BEGIN
		--Remove duplicate CRLF
		SET @rtnStr = @p_Str;
		SET @CRLFExist = CHARINDEX(@rtnStr, CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10));

		--Loop through and remove multiple CRLF.
		WHILE 1 = 1
		BEGIN
			SET @rtnStr = REPLACE(@rtnStr, CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10), CHAR(13) + CHAR(10))
			SET @CRLFExist = CHARINDEX(@rtnStr, CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10))
			IF @CRLFExist = 0
				BREAK;
		END --WHILE
		--Loop through and remove leading CRLF.
		SET @CRLFExist = CHARINDEX(@rtnStr, CHAR(13) + CHAR(10))
		IF @CRLFExist = 1
		BEGIN
			WHILE 1 = 1
			BEGIN
				SET @rtnStr = SUBSTRING(@rtnStr, 3,LEN(@rtnStr));
				SET @CRLFExist = CHARINDEX(@rtnStr, CHAR(13) + CHAR(10))
				IF @CRLFExist = 0 OR @CRLFExist > 1  OR @CRLFExist IS NULL
					BREAK;
			END
		END
		WHILE 1 =1
		BEGIN
			IF SUBSTRING(@rtnStr, LEN(@rtnStr) - 1, LEN(@rtnStr)) = CHAR(13) + CHAR(10)
				SET @rtnStr = SUBSTRING(@rtnStr, 1, LEN(@rtnStr) - 2)
			ELSE
				BREAK;
		END --WHILE
	END --ELSE
	RETURN TRIM(UPPER(@rtnStr))
END
