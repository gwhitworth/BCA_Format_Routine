/****** Object:  Table [dbo].[NameAddress]    Script Date: 10/19/2018 2:58:12 PM ******/
DROP TABLE IF EXISTS [dbo].[NameAddress]
GO

/****** Object:  Table [dbo].[NameAddress]    Script Date: 10/19/2018 2:58:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NameAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NameAddress](
	[Owner_CompName] [nvarchar](50) NULL,
	[Owner_FName] [nvarchar](50) NULL,
	[Owner_MName] [nvarchar](50) NULL,
	[Owner_LName] [nvarchar](50) NULL,
	[Care_Of] [nvarchar](50) NULL,
	[Attention] [nvarchar](50) NULL,
	[dimAddress_BK] [nvarchar](50) NOT NULL,
	[dimCountry_SK] [int] NOT NULL,
	[dimProvince_SK] [int] NOT NULL,
	[dimCity_SK] [int] NOT NULL,
	[dimStreetDirection_SK] [int] NOT NULL,
	[dimStreetType_SK] [int] NOT NULL,
	[dimUnitType_SK] [int] NOT NULL,
	[dimCountry_BK] [nvarchar](50) NOT NULL,
	[dimProvince_BK] [nvarchar](50) NULL,
	[dimCity_BK] [nvarchar](50) NULL,
	[dimStreetDirection_BK] [nvarchar](50) NULL,
	[dimStreetType_BK] [nvarchar](50) NULL,
	[dimUnitType_BK] [nvarchar](1) NULL,
	[Country_Code] [int] NOT NULL,
	[Country_Desc] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[Province_Desc] [nvarchar](50) NULL,
	[City_Desc] [nvarchar](50) NULL,
	[Street_Suffix] [nvarchar](50) NULL,
	[Street_Suffix_2] [nvarchar](50) NULL,
	[Street_Direction_Desc] [nvarchar](50) NULL,
	[Address_Line_1] [nvarchar](50) NULL,
	[Address_Line_2] [nvarchar](1) NULL,
	[Address_Line_3] [nvarchar](1) NULL,
	[Address_Type_Code] [nvarchar](50) NOT NULL,
	[Address_Number_Suffix] [nvarchar](1) NULL,
	[Grid_Address_Number] [nvarchar](1) NULL,
	[Street_Number] [nvarchar](50) NULL,
	[Address_Street_Name] [nvarchar](50) NULL,
	[Carrier_Route] [nvarchar](1) NULL,
	[Postal_Index_Number] [nvarchar](1) NULL,
	[Postal_Zip_Code] [nvarchar](50) NULL,
	[Address_Unit_Description] [nvarchar](1) NULL,
	[Address_Unit] [nvarchar](50) NULL,
	[Zip_Code_First_5_Digits] [nvarchar](50) NULL,
	[Zip_Code_Suffix_Last_4_Digits] [nvarchar](50) NULL,
	[Floor_Number] [nvarchar](1) NULL,
	[Delivery_Mode_Desc] [nvarchar](50) NULL,
	[Delivery_Mode_Value] [nvarchar](50) NULL,
	[Site] [nvarchar](1) NULL,
	[Compartment] [nvarchar](1) NULL,
	[Delivery_Installation_Type_Code] [nvarchar](50) NULL,
	[Delivery_Installation_Type_Value] [nvarchar](50) NULL,
	[Address_Line_4] [nvarchar](1) NULL,
	[Address_Line_5] [nvarchar](1) NULL,
	[Street_Prefix] [nvarchar](1) NULL
)
END
GO