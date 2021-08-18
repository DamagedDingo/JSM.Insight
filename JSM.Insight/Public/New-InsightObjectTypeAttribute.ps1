
function New-InsightObjectTypeAttribute {
    [CmdletBinding()]
    param (
        [string]$ObjectTypeId,
        [string]$Name,
        [string]$Label,
        [string]$Description,
        [ValidateSet("Default","Object Reference","User","Group","Status")]
        [string]$Type,
        [ValidateSet("None","Text","Integer","Boolean","Double","Date","Time","DateTime","URL","Email","TextArea","Select","IP Address")]
        [string]$defaultTypeId,
        [string]$typeValue,
        [array]$typeValueMulti,
        [string]$additionalValue,
        [int]$minimumCardinality,
        [int]$maximumCardinality,
        [string]$suffix,
        [bool]$includeChildObjectTypes,
        [bool]$hidden,
        [bool]$uniqueAttribute,
        [bool]$summable,
        [string]$regexValidation,
        [string]$iql,
        [string]$options,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders

        $ConvertedTypeID = switch ($Type) {
            "Default" { 0 }
            "Object Reference" { 1 }
            "User" { 2 }
            "Group" { 4 }
            "Status" { 7 }
        }

        $ConvertedDefaultTypeID = switch ($defaultTypeId) {
            "None" { -1 }
            "Text" { 0 }
            "Integer" { 1 }
            "Boolean" { 2 }
            "Double" { 3 }
            "Date" { 4 }
            "Time" { 5 }
            "DateTime" { 6 }
            "URL" { 7 }
            "Email" { 8 }
            "TextArea" { 9 }
            "Select" { 10 }
            "IP Address" { 11 }
        }


        $RequestBody = @{
            'name' = $Name
            'type'   = $ConvertedTypeID
            }
            if ($Label) {
                $RequestBody.Add('label', [System.Convert]::ToBoolean($Label) )
            }
            if ($Description) {
                $RequestBody.Add('description', $Description)
            }
            if ($defaultTypeId) {
                $RequestBody.Add('defaultTypeId', $ConvertedDefaultTypeID)
            }
            if ($typeValue) {
                $RequestBody.Add('typeValue', $typeValue)
            }
            if ($typeValueMulti) {
                $RequestBody.Add('typeValueMulti', $typeValueMulti)
            }
            if ($additionalValue) {
                $RequestBody.Add('additionalValue', $additionalValue)
            }
            if ($minimumCardinality) {
                $RequestBody.Add('minimumCardinality', $minimumCardinality)
            }
            if ($maximumCardinality) {
                $RequestBody.Add('maximumCardinality', $maximumCardinality)
            }
            if ($suffix) {
                $RequestBody.Add('suffix', $suffix)
            }
            if ($includeChildObjectTypes  -eq $true) {
                $RequestBody.Add('includeChildObjectTypes', [System.Convert]::ToBoolean($includeChildObjectTypes) )
            }
            if ($hidden -eq $true) {
                $RequestBody.Add('hidden', [System.Convert]::ToBoolean($hidden) )
            }
            if ($uniqueAttribute -eq $true) {
                $RequestBody.Add('uniqueAttribute', [System.Convert]::ToBoolean($uniqueAttribute) )
            }
            if ($summable -eq $true) {
                $RequestBody.Add('summable', [System.Convert]::ToBoolean($summable) )
            }
            if ($regexValidation) {
                $RequestBody.Add('regexValidation', $regexValidation)
            }
            if ($iql) {
                $RequestBody.Add('iql', $iql)
            }
            if ($options) {
                $RequestBody.Add('options', $options)
            }

        $RequestBody = ConvertTo-Json $RequestBody -Depth 1
        $RequestBody
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objecttypeattribute/$ObjectTypeId"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -ErrorRecord $_
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}