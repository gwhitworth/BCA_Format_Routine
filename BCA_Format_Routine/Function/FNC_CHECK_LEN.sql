DROP FUNCTION IF EXISTS [dbo].[FNC_CHECK_LEN]
GO
/*********************************************************************************************************************
Function: FUNCTION FNC_CHECK_LEN

Purpose: This is a function to get the final result of address line

Parameter: pv_temp(field content), pv_line_length,

Return/result: > than the constraint, truncate the field until it fit in the cosntraint
            otherwise, return back the field

Assumption: The parameters are not null

Modified History:
Version		Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0         Nov 2018    original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_CHECK_LEN]
(
	@p_temp VARCHAR, 
	@p_line_length INT
)
RETURNS VARCHAR
AS
BEGIN
	DECLARE @RtnStr		VARCHAR,
			@len		INT,
			@start		INT,
			@end		INT,
			@addr		varchar(2000),
			@i			INT

	IF LEN(@p_temp) <= @p_line_length
		SET @RtnStr = @p_temp
	ELSE
	BEGIN
		SET @start = 1
		SET @end = @p_line_length
		SET @addr = UPPER(TRIM(SUBSTRING(TRIM(@p_temp), @start, @end)))
		/*to see if the last char is space or not because oracle will take off the space to check the length
		of the variable so the length of the variable is not exactly what we want*/
		IF LEN(@addr) <> @p_line_length
			SET @len = @p_line_length
		ELSE
			SET @len = LEN(@addr)

		IF SUBSTRING(@addr, @len, 1) <> ' '
		BEGIN
			SET @i = @end
			WHILE @i > 1
			BEGIN
				IF SUBSTRING(@p_temp, @i, 1) = ' '
					SET @i = 0

				SET @i = @i - 1
			END --WHILE
		END --IF
		SET @RtnStr = UPPER(TRIM(SUBSTRING(TRIM(@p_temp), 1, @end-1)))
	END --ELSE
	IF @@ERROR <> 0
		RETURN NULL

	RETURN @RtnStr
END
