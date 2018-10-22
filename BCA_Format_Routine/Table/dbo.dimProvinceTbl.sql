CREATE TABLE [dbo].[dimProvinceTbl] (
    [dimProvince_SK]      INT           NOT NULL,
    [dimProvince_BK]      NVARCHAR (50) NOT NULL,
    [dimCountry_SK]       INT           NULL,
    [dimCountry_BK]       NVARCHAR (50) NULL,
    [Province_Code]       NVARCHAR (50) NOT NULL,
    [Province_Desc]       NVARCHAR (50) NOT NULL,
    [Province]            NVARCHAR (50) NOT NULL,
    [Province_Short_Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_dimProvinceTbl] PRIMARY KEY CLUSTERED ([dimProvince_SK] ASC)
);

