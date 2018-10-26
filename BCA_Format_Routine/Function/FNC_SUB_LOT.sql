DROP FUNCTION IF EXISTS [dbo].[FNC_SUB_LOT]
GO
/*********************************************************************************************************************
Function: FNC_SUB_LOT

Purpose: This is a function to find the prefix of sub_lot

Parameter: pv_jurisdiction

Return/result: a prefix: if pv_jurisdiction is 307 or 234, prefix is Suburban Lot 
            otherwise; prefix is Subsidy Lot
            
Assumption: None

Modified History: 
Version    Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0       June 2005   original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_SUB_LOT]
(
	@pv_jurisdiction VARCHAR(10)
)
RETURNS VARCHAR(200)
AS
BEGIN
	DECLARE @Rtn VARCHAR(20) = ''

	IF TRIM(@pv_jurisdiction) = '234' OR @pv_jurisdiction = '307'
		SET @Rtn = 'Suburban Lot'
	ELSE    
		SET @Rtn = 'Sublot'

	RETURN @Rtn
END
