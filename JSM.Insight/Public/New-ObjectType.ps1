
function New-ObjectType {
    [CmdletBinding()]
    param (
        [string]$ID,
        [string]$name,
        [string]$description,
        [string]$iconID,
        [string]$ObjectSchemaID,
        [string]$ParentObjectTypeID,
        [switch]$Inherited,
        [switch]$AbstractObjectType,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkstationID = $InsightWorkstationID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Headers = New-Headers

        $RequestBody = @{
            'name' = $Name
            'iconID'   = $iconID
            'objectSchemaId'   = $objectSchemaId
            }
            if ($Description) {
                $RequestBody.Add('Description', $Description)
            }
            if ($parentObjectTypeId) {
                $RequestBody.Add('parentObjectTypeId', $parentObjectTypeId)
            }
            if ($Inherited -eq $true) {
                $RequestBody.Add('Inherited', $Inherited)
            }
            if ($AbstractObjectType -eq $true) {
                $RequestBody.Add('AbstractObjectType', $AbstractObjectType)
            }

        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkstationID/v$Version/objecttype/create"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}