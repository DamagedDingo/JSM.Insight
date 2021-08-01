# Custom Function to Get Object Type, Attributes, and All Objects 
function Get-InsightFullObjectType {
    [CmdletBinding()]
    param (
        [string]$ObjectSchemaName,
        [string]$ObjectTypeName
    )
	
    begin {
        Write-PSFMessage -Level Host -Message "Starting 'Get-InsightFullObjectType'" -Tag 'Get-InsightFullObjectType'

        $ObjectSchema = (Get-InsightObjectSchemaList).values | Where-Object { $_.name -eq $ObjectSchemaName }
        $ObjectSchemaObjectTypes = Get-InsightObjectSchemaObjectTypes -ID $ObjectSchema.id

        $JSMObjects = @()
        $objs = @()
        $page = 0

        class JSMexport {
            [string]$name
            [Object]$objectType
            [Object]$attributes
            [Object]$objects
        }
    }
	
    process {
        $e = [JSMexport]::New()
        $e.objectType = Get-InsightObjectType -ID $($ObjectSchemaObjectTypes | Where-Object { $_.name -eq $ObjectTypeName }).id
        $e.attributes = Get-InsightObjectTypeAttributes -ID $($ObjectSchemaObjectTypes | Where-Object { $_.name -eq $ObjectTypeName }).id
        #Loop through and return all objects. IncludeAttributes to get 'attributes and values' for the objects themselves
        do {
            $page++
            Write-PSFMessage -Level Host -Message "Preforming 'Find-InsightObject' on page: $page" -Tag 'Get-InsightFullObjectType'
            $results = Find-InsightObject -objectSchemaId $ObjectSchema.id -objectTypeId $e.objectType.id -resultsPerPage 2000 -page $page -IQL ${objectType = "$ObjectTypeName"} -includeAttributes $true
            $objs += $results.objectEntries
        } until ( ( $page -eq $results.pageSize ) -or ( !($results.objectEntries) ) )
        $e.objects = $objs
        $e.name = $e.objectType.name
        $JSMObjects += $e
    }
	
    end {
        Write-PSFMessage -Level Host -Message "Completed 'Get-InsightFullObjectType'" -Tag 'Get-InsightFullObjectType'
        $JSMObjects
    }
} 