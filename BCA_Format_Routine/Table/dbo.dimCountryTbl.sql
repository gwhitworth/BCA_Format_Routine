DROP TABLE IF EXISTS [dbo].[dimCountryTbl]
GO
CREATE TABLE [dbo].[dimCountryTbl] (
    [dimCountry_SK] INT           NOT NULL,
    [dimCountry_BK] NVARCHAR (50) NOT NULL,
    [Country_Desc]  NVARCHAR (50) NOT NULL,
    [Country_Code]  NVARCHAR (50) NOT NULL,
    [Country]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_dimCountryTbl] PRIMARY KEY CLUSTERED ([dimCountry_SK] ASC)
);

