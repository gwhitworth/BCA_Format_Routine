IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FolioFormattedPID]') AND type in (N'U'))
ALTER TABLE [dbo].[FolioFormattedPID] DROP CONSTRAINT IF EXISTS [DF_FolioFormattedPID_DateTimeStamp]
GO

/****** Object:  Table [dbo].[FolioFormattedPID]    Script Date: 10/30/2018 3:32:09 PM ******/
DROP TABLE IF EXISTS [dbo].[FolioFormattedPID]
GO

/****** Object:  Table [dbo].[FolioFormattedPID]    Script Date: 10/30/2018 3:32:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FolioFormattedPID]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FolioFormattedPID](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FolioNumber] [varchar](50) NOT NULL,
	[FormattedPID] [varchar](max) NOT NULL,
	[DateTimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_FolioFormattedPID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FolioFormattedPID_DateTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FolioFormattedPID] ADD  CONSTRAINT [DF_FolioFormattedPID_DateTimeStamp]  DEFAULT (getdate()) FOR [DateTimeStamp]
END
GO


