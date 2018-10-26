DROP FUNCTION IF EXISTS [dbo].[FNC_TOWNSHIP_DESC]
GO
/*********************************************************************************************************************
Function: FNC_TOWNSHIP_DESC

Purpose: This is a function is get the township description from the look up table
       AO_U_Township_Code 
       
Parameter: p_township_code

Return/result: description if found, else return null
            
Assumption: None

Modified History: 
Version    Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0       Nov 2018   original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_TOWNSHIP_DESC]
(
	@p_township_code VARCHAR(10)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Rtn		VARCHAR(500) = '',
			@des		VARCHAR(500) = '',
			@pos		INT = 0,
			@Chr		VARCHAR(1) = '',
			@LZero		BIT = 1,
			--@list		t_Township_TB;
			@Count		INT,
			@i			INT = 0;

	IF @p_township_code IS NOT NULL
    BEGIN
      --SELECT l.CODE
      --     , l.DESCRIPTION
      --BULK COLLECT INTO @list
      --FROM BCA_AO.AO_U_TOWNSHIP_CODE l
      --WHERE  l.code = @p_township_code;

      -- if description not found, use the code 
      --SET @Count = @list.count
      
		IF @Count = 0
		BEGIN
			SET @pos = LEN(@p_township_code)
			WHILE 1 = 1 	
			BEGIN
				IF @i = @pos
					BREAK;
			
				-- Get character   
				SET @Chr = SUBSTRING(@p_township_code, @i, 1)

				--if it is NOT leading Zero 
				IF (@Chr = '0' )
				BEGIN
					IF @LZero <> 1
						SET @des = @des + @Chr;
				END
				ELSE
				BEGIN
					SET @des = @des + @Chr
					-- Set not leading zero flag 
					SET @LZero = 0;
				END
				SET @i = @i + 1
			END --WHILE
			SET @Rtn = @des
		END    
      --ELSE
          --SET @Rtn = TRIM(@list(1).township_Desc); 
	END
	RETURN @Rtn
END