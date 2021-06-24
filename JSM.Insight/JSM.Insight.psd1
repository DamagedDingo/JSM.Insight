#
# Module manifest for module 'JSM.Insight'
#
# Generated by: Gary Smith
#
# Generated on: 06/06/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'JSM.Insight.psm1'

# Version number of this module.
ModuleVersion = '1.19'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'fbab056b-f110-4574-8ac7-28b5e72d394a'

# Author of this module
Author = 'Gary Smith'

# Company or vendor of this module
CompanyName = 'DamagedDingo'

# Copyright statement for this module
Copyright = '(c) 2021 Gary Smith. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A collection of Powershell tools to interface with the API for the Intergrated version of Insight within Jira Service Management.'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('PSFramework')

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Find-InsightObject', 'Get-InsightCreds', 'Get-InsightIcon', 
                    'Get-InsightObject', 'Get-InsightObjectAttributes', 
                    'Get-InsightObjectByIQL', 'Get-InsightObjectConnectedTickets', 
                    'Get-InsightObjectHistory', 'Get-InsightObjectReferenceInfo', 
                    'Get-InsightObjectSchema', 'Get-InsightObjectSchemaAttributes', 
                    'Get-InsightObjectSchemaList', 'Get-InsightObjectSchemaObjectTypes', 
                    'Get-InsightObjectType', 'Get-InsightObjectTypeAttributes', 
                    'Get-InsightProgressCatagoryImports', 'Get-InsightStatusTypeByID', 
                    'Get-InsightStatusTypes', 'Get-InsightWorkspaceID', 
                    'New-InsightAttributeArray', 'New-InsightObject', 
                    'New-InsightObjectSchema', 'New-InsightObjectType', 
                    'New-InsightObjectTypeAttribute', 'New-InsightStatusType', 
                    'Remove-InsightObject', 'Remove-InsightObjectSchema', 
                    'Remove-InsightObjectType', 'Remove-InsightObjectTypeAttribute', 
                    'Remove-InsightStatusType', 'Set-InsightObject', 
                    'Set-InsightObjectPosition', 'Set-InsightObjectSchema', 
                    'Set-InsightObjectType', 'Set-InsightObjectTypeAttribute', 
                    'Set-InsightStatusType'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Jira','Insight','JSM.Insight','API','CMDB','Asset','JSM','JiraServiceManagement'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/DamagedDingo/JSM.Insight/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/DamagedDingo/JSM.Insight'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'Added
- Updated Get-InsightStatusTypes to support SchemaID'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

