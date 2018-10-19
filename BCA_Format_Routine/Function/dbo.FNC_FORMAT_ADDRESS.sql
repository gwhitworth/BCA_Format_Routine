DROP FUNCTION IF EXISTS [dbo].[FNC_FORMAT_ADDRESS]
GO
/*********************************************************************************************************************
Function: FNC_FORMAT_ADDRESS

Purpose: This is a common function to format owner address

Parameter:

Return/result: an address line

Assumption: none

Modified History:
Author.....................Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0........................Nov 2018......original build       Gerry Whitworth

*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_FORMAT_ADDRESS]
(
	@param1 int,
	@param2 int
)


RETURNS varchar(max)
AS
BEGIN
	DECLARE @rtnValue varchar(max)
	SET @rtnValue = ''
	RETURN @rtnValue
END