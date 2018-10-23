/*********************************************************************************************************************
Function: dbo.SP_LOG_ERROR

Purpose: This proc is used for logging errors that may occur while testing formatting logic

Parameter: @ErrMessage,	@ErrState, @ErrSeverity

Result: Add Error details to error table and raise error.  
		This is for testing

Assumption: none

Modified History:
Author.....................Date...........Purpose.............Developer
---------------------------------------------------------------------------------------------------------------------
1.0........................Nov 2018......original build       Gerry Whitworth
*********************************************************************************************************************/
CREATE OR ALTER PROCEDURE [dbo].[SP_LOG_ERROR]
	@ErrMessage varchar(500),
	@ErrState int,
	@ErrSeverity int
AS
BEGIN
	INSERT INTO [dbo].[FormattingErrorLog] ([ErrorMessage],[ErrorState],[ErrorSeverity])
		VALUES (@ErrMessage, @ErrState, @ErrSeverity)

	RAISERROR(@ErrMessage, @errSeverity, @errState);
END
