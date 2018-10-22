/*********************************************************************************************************************
Function: FNC_GET_ADDRESS_LINE

Purpose: This is a function to divide the freeform from address into different lines (at most 5)

Parameter: pv_freeform_address, pv_line_length, pv_line_number

Return/result: an address line with fixed line length
            remark: the whole word won't be truncated i.e. the line of length maybe shorter

Assumption: The parameter of park_folio_id has been formated.

Modified History:
Version         Date		Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0				Nov 2018	original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_GET_ADDRESS_LINE]
(
	@p_Address VARCHAR,
	@p_line_length INT, 
	@p_line_number INT
)
RETURNS VARCHAR
AS
BEGIN
	DECLARE @RtnStr		VARCHAR,
			@addr		VARCHAR(2000),
			@start		INT,
			@end		INT

	SET @end = CHARINDEX(@p_Address, CHAR(13), 1, @p_line_number);
	IF @p_line_number > 1
		SET @start = CHARINDEX(@p_Address, CHAR(10), 1, @p_line_number - 1) + 1;
	ELSE--pv_line number = 1
		SET @start = 1
	
	IF @end > 0
		SET @end = @end - @start






	RETURN @RtnStr
END
