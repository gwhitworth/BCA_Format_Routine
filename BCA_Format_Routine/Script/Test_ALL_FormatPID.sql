﻿DBCC FREEPROCCACHE
GO
DBCC DROPCLEANBUFFERS
GO
TRUNCATE TABLE [dbo].[FolioFormattedPID]
GO
EXEC dbo.[SP_TEST_FORMAT_PID]
GO
SELECT * FROM [EDW].[dbo].[FolioFormattedPID]
GO