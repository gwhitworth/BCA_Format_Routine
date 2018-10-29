IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LegalDescription]') AND type in (N'U'))
ALTER TABLE [dbo].[LegalDescription] DROP CONSTRAINT IF EXISTS [DF_LegalDescription_DateTimeStamp]
GO

/****** Object:  Table [dbo].[LegalDescription]    Script Date: 10/29/2018 12:46:56 PM ******/
DROP TABLE IF EXISTS [dbo].[LegalDescription]
GO

/****** Object:  Table [dbo].[LegalDescription]    Script Date: 10/29/2018 12:46:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LegalDescription]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LegalDescription](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LegalDescription] [varchar](max) NOT NULL,
	[DateTimeStamp] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LegalDescription] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_LegalDescription_DateTimeStamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LegalDescription] ADD  CONSTRAINT [DF_LegalDescription_DateTimeStamp]  DEFAULT (getdate()) FOR [DateTimeStamp]
END
GO


