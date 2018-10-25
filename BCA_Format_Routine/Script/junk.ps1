# Generated by SQL Server Management Studio at 11:11 AM on 10/25/2018

Import-Module SqlServer
# Set up connection and database SMO objects

$sqlConnectionString = "Data Source=localhost;Initial Catalog=EDW;Integrated Security=True;MultipleActiveResultSets=False;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;Packet Size=4096;Application Name=`"Microsoft SQL Server Management Studio`""
$smoDatabase = Get-SqlDatabase -ConnectionString $sqlConnectionString

# If your encryption changes involve keys in Azure Key Vault, uncomment one of the lines below in order to authenticate:
#   * Prompt for a username and password:
#Add-SqlAzureAuthenticationContext -Interactive

#   * Enter a Client ID, Secret, and Tenant ID:
#Add-SqlAzureAuthenticationContext -ClientID '<Client ID>' -Secret '<Secret>' -Tenant '<Tenant ID>'

# Change encryption schema

$encryptionChanges = @()

# Add changes for table [dbo].[Junk]
$encryptionChanges += New-SqlColumnEncryptionSettings -ColumnName dbo.Junk.Junk -EncryptionType Deterministic -EncryptionKey "CEK_Auto2"

Set-SqlColumnEncryption -ColumnEncryptionSettings $encryptionChanges -InputObject $smoDatabase

