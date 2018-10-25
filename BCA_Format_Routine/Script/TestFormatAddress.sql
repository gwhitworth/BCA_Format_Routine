DBCC FREEPROCCACHE
GO
DBCC DROPCLEANBUFFERS
GO
  DECLARE @Type				VARCHAR(10),
		@RequestedLineNum	INT

--SET @Type = 'BCSIMPLE'
--SET @Type = 'CO'
--SET @Type = 'ATTN'
--SET @Type = 'CO_ATTN'
SET @Type = 'USA'

SET @RequestedLineNum = 2;

EXEC dbo.SP_TEST_FORMAT_ONE_ADDRESS @Type, @RequestedLineNum