DROP FUNCTION IF EXISTS [dbo].[GET_FORMAT_LINE]
GO
--********************************************************************************
--* Application:   Roll Data
--*
--* Function:      GET_FORMAT_LINE
--*
--* Purpose:       Takes a string as input and returns A string with specifying 
--*                line length and line number. 
--*
--* Maintenance Log:
--*
--* Ver.Rel     Date     Developer/Description
--* -------  ----------  ---------------------------------------------------------
--* 1.0      Nov 2018    GW /  Initial Version
--*********************************************************************************
CREATE FUNCTION [dbo].[GET_FORMAT_LINE]
(
	@p_inputStr		VARCHAR(500),
	@p_inputLength  INT,
	@p_inputLineNo  INT
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ReturnStr  VARCHAR(2000) = '',
			@tempStr    VARCHAR(2000) = '',
			@StartPos   INT,
			@SpacePos   INT,
			@ThisPos    INT,
			@NextPos    INT,
			@ThisLength INT,
			@i			INT = 0,
			@j			INT = 0

IF @p_inputStr IS NULL
	RETURN NULL;
ELSE  
BEGIN     
	SET @tempStr = TRIM(@p_inputStr)
      
	-- case of short text
	IF LEN(@tempStr) < @p_inputLength
	BEGIN
		IF @p_inputLineNo = 1
			SET @ReturnStr = @tempStr
		ELSE
			SET @ReturnStr = NULL
	END
	ELSE
	BEGIN
		SET @StartPos	= 0
		SET @SpacePos	= 0
		SET @ThisPos	= 0
		SET @NextPos	= 0
		SET @ThisLength = 0
    
		WHILE @i <= @p_inputLineNo
		BEGIN
			-- check if the line (2nd or greater) is nothing, return null
			IF TRIM(SUBSTRING (@tempStr, @StartPos + 1, @p_inputLength)) = '' 
					OR SUBSTRING (@tempStr, @StartPos + 1, @p_inputLength) IS NULL
				SET @ReturnStr = NULL;
			ELSE
			BEGIN
				SET @j = @StartPos + 1
				WHILE @j <= (@StartPos + @p_inputLength)
				BEGIN
					IF SUBSTRING (@tempStr, @j, 1) = ' '
						SET @SpacePos = @j;
					ELSE
						SET @ThisPos = @j;
				END
				SET @NextPos = @ThisPos + 1;
				-- case of cut right on the end of a word 
				IF SUBSTRING (@tempStr, @NextPos, 1) = ' '
				BEGIN
					SET @ThisLength = @thisPos - @StartPos;
					SET @ReturnStr	= SUBSTRING (@tempStr, @StartPos + 1, @ThisLength);
					SET @StartPos	= @ThisPos;
				END
				ELSE
				BEGIN
					IF (@SpacePos > @StartPos)
					BEGIN
						-- case of last word in the string 
						IF SUBSTRING (@tempStr, @ThisPos + 1, 1) IS NULL
								OR TRIM(SUBSTRING (@tempStr, @ThisPos, 1)) = ''
						BEGIN
							SET @ThisLength = @ThisPos - @StartPos
							SET @ReturnStr	= SUBSTRING (@tempStr, @StartPos + 1, @ThisLength);
							SET @StartPos	= @ThisPos;
						END	
						ELSE
						BEGIN
							SET @ThisLength	= @SpacePos - 1 - @StartPos
							SET @ReturnStr	= SUBSTRING (@tempStr, @StartPos + 1, @ThisLength)
							SET @StartPos	= @SpacePos
						END
						-- case of last word in the string 
					END
					ELSE
					BEGIN
						SET @ThisLength = @ThisPos - @StartPos;
						SET @ReturnStr	= SUBSTRING (@tempStr, @StartPos + 1, @ThisLength);
						SET @StartPos	= @ThisPos;
					END
				END
			END
			-- in case of the first char is space 
			IF SUBSTRING (@tempStr, @StartPos + 1, 1 ) = ' '
				SET @StartPos = @StartPos + 1
			END
		END
	END
	RETURN @ReturnStr
END