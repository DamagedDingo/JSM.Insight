# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

Add comment under [Unreleased] and commit with !Deploy!
Format as below (Requires the '### Added' as a header or task fails)
...### Added
...- Move Test-Module from Private to public\build
...- Update ReadMe.MD

## [Unreleased]

## [1.26] - 2021-08-18
### Added
- All Error handling has been chnaged to provide complete error as the API was not responding consistently.
- Write-Error -ErrorRecord $_

## [1.25] - 2021-08-18
### Added
- Get-InsightObject updated error message to use $_.ErrorDetails.Message which should be more useful. 

## [1.24] - 2021-08-16
### Added
- Invoke-HostInfo REPLACEMENT FOR INSIGHT DISCOVERY AGENT WINDOWS ONLY
- Get-InsightFullObjectType updated with a fast option to ignore objects

## [1.23] - 2021-08-01
### Added
- Get-InsightFullObjectType - ( ( $page -eq $results.pageSize ) -or ( !($results.objectEntries) ) )

## [1.22] - 2021-07-30
### Added
- Get-InsightFullObjectType as it still was not catching null values: ( ( $page -eq $results.pageSize ) -or ( $($results.objectEntries).count -eq 0 ) )

## [1.21] - 2021-07-30
### Added
- Get-InsightFullObjectType changed page size from 0 to 1 for when there are no results

## [1.20] - 2021-06-24
### Added
- Added 'Get-InsightFullObjectType' to provide a way to get all infomration for an object type (Object Type, Attributes, and all Objects) WARNING: Not tested with more then 5000 objects.
- Added requirement for module 'PSFramework' which will be used for logging going forward.

## [1.19] - 2021-06-06
### Added
- Updated Get-InsightStatusTypes to support SchemaID

## [1.18] - 2021-06-06
### Added
- New-InsightStatusType and Set-InsightStatusType updated to use int for category.
- Raised page size on Find-InsightObject

## [1.17] - 2021-06-02
### Added
- Set-InsightObject and Get-InsightObject updated to suport more depth for JSON.
- Set-InsightObject and New-InsightObject updated array var name

## [1.16] - 2021-06-01
### Added
- Forced to update all functions by prefixing with 'Insight' due to too many clashes with internal powershell functions. Note: will need to remove any old version of 'PSInsight'.
- New-InsightObjectByID - Default to create

## [1.15] - 2021-06-01
### Added
- Bug fix New-ObjectTypeAttribute not setting defaultTypeId

## [1.14] - 2021-05-31
### Added
- Fixed case sensitive parameters 

## [1.13] - 2021-05-28
### Added
- Fix copy\paste issues in some functions (-Body $RequestBody)

## [1.12] - 2021-05-28
### Added
- Updated from switch to Bool to allow for easier scripting. 

## [1.11] - 2021-05-28
### Added
- Update all fuctions to use $InsightWorkspaceID instead of $InsightWorkstationID.

## [1.10] - 2021-05-28
### Added
- Set-ObjectPosition (Function name was incorrect)

## [1.9] - 2021-05-28
### Added
- Forced whole module overwrite stop corrupt build

## [1.8] - 2021-05-28
### Added
- Repair JSM.Insight.psd1

## [1.7] - 2021-05-27
### Added
- Renamed Get-Object, Set-Object, New-Object, Remove-Object to Get-ObjectByID, Set-ObjectByID, New-ObjectByID, Remove-ObjectByID because these are system names.

## [1.6] - 2021-05-27
### Added
- Removed URI from get-headers
- Renamed Get-Object, Set-Object, New-Object, Remove-Object to Get-ObjectByID, Set-ObjectByID, New-ObjectByID, Remove-ObjectByID because these are system names.


## [1.5] - 2021-05-27
### Added
- Corrupt package. CallDepthOverflow

## [1.4] - 2021-05-27
### Added
- Fix CmdletBinding in Get-InsightWorkspaceID

## [1.3] - 2021-05-27
### Added
- Typo fix

## [1.2] - 2021-05-27
### Added
- Bug fix

## [1.1] - 2021-05-27
### Added
- Added Get-InsightCreds
- Added Get-InsightWorkspaceID
- Delete Set-InsightServer (Only used once, no need for function)

## [1.0] - 2021-05-25
### Added
- Publish Beta to PowerShell Gallary
- Added PS Gallery API Key 

[Unreleased]: https://github.com/DamagedDingo/JSM.Insight/compare/1.26..HEAD
[1.26]: https://github.com/DamagedDingo/JSM.Insight/compare/1.25..1.26
[1.25]: https://github.com/DamagedDingo/JSM.Insight/compare/1.24..1.25
[1.24]: https://github.com/DamagedDingo/JSM.Insight/compare/1.23..1.24
[1.23]: https://github.com/DamagedDingo/JSM.Insight/compare/1.22..1.23
[1.22]: https://github.com/DamagedDingo/JSM.Insight/compare/1.21..1.22
[1.21]: https://github.com/DamagedDingo/JSM.Insight/compare/1.20..1.21
[1.20]: https://github.com/DamagedDingo/JSM.Insight/compare/1.19..1.20
[1.19]: https://github.com/DamagedDingo/JSM.Insight/compare/1.18..1.19
[1.18]: https://github.com/DamagedDingo/JSM.Insight/compare/1.17..1.18
[1.17]: https://github.com/DamagedDingo/JSM.Insight/compare/1.16..1.17
[1.16]: https://github.com/DamagedDingo/JSM.Insight/compare/1.15..1.16
[1.15]: https://github.com/DamagedDingo/JSM.Insight/compare/1.14..1.15
[1.14]: https://github.com/DamagedDingo/JSM.Insight/compare/1.13..1.14
[1.13]: https://github.com/DamagedDingo/JSM.Insight/compare/1.12..1.13
[1.12]: https://github.com/DamagedDingo/JSM.Insight/compare/1.11..1.12
[1.11]: https://github.com/DamagedDingo/JSM.Insight/compare/1.10..1.11
[1.10]: https://github.com/DamagedDingo/JSM.Insight/compare/1.9..1.10
[1.9]: https://github.com/DamagedDingo/JSM.Insight/compare/1.8..1.9
[1.8]: https://github.com/DamagedDingo/JSM.Insight/compare/1.7..1.8
[1.7]: https://github.com/DamagedDingo/JSM.Insight/compare/1.6..1.7
[1.6]: https://github.com/DamagedDingo/JSM.Insight/compare/1.5..1.6
[1.5]: https://github.com/DamagedDingo/JSM.Insight/compare/1.4..1.5
[1.4]: https://github.com/DamagedDingo/JSM.Insight/compare/1.3..1.4
[1.3]: https://github.com/DamagedDingo/JSM.Insight/compare/1.2..1.3
[1.2]: https://github.com/DamagedDingo/JSM.Insight/compare/1.1..1.2
[1.1]: https://github.com/DamagedDingo/JSM.Insight/compare/1.0..1.1
[1.0]: https://github.com/DamagedDingo/JSM.Insight/tree/1.0