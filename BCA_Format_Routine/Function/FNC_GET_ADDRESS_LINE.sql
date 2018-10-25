DROP FUNCTION IF EXISTS [dbo].[FNC_GET_ADDRESS_LINE]
GO
/*********************************************************************************************************************
Function: FNC_GET_ADDRESS_LINE

Purpose: This is a function to divide the freeform from address into different lines (at most 5)

Parameter: p_freeform_address, p_line_length, p_line_number

Return/result: an address line can be any length

Assumption: None

Modified History:
Version         Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0				Nov 2018	original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_GET_ADDRESS_LINE]
(
	@p_Address VARCHAR(500) = '',
	@p_line_length INT, 
	@p_line_number INT
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @RtnStr		VARCHAR(500) = '',
			@addr		VARCHAR(2000) = '',
			@start		INT,
			@end		INT

	SET @end = dbo.INSTR(@p_Address, CHAR(10), 0, @p_line_number)
	IF @p_line_number > 1
	BEGIN
		SET @start = dbo.INSTR(@p_Address, CHAR(13), 0, @p_line_number-1)
	END
	ELSE--pv_line number = 1
		SET @start = 1

	
	IF @end > 0
		SET @end = @end - @start

	IF @end > 0 AND @start > 0 --any line of address including 1st line
		SET @RtnStr = dbo.FNC_CHECK_LEN(SUBSTRING(@p_Address, @start, @end), @p_line_length)
	ELSE IF (@end = 0 AND @start > 1) OR (@end = 0 AND @start = 1 AND @p_line_number = 1) --last line or 1st line and no more another line of address
		SET @RtnStr = dbo.FNC_CHECK_LEN(SUBSTRING(@p_Address, @start, LEN(TRIM(@p_Address))), @p_line_length)
	ELSE --no data of address line
		SET @RtnStr = NULL

	RETURN @RtnStr
END
