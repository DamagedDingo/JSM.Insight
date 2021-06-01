
function New-InsightObjectType {
    [CmdletBinding()]
    param (
        [string]$name,
        [string]$description,
        [string]$iconID,
        [string]$ObjectSchemaID,
        [string]$ParentObjectTypeID,
        [bool]$Inherited,
        [bool]$AbstractObjectType,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Headers = New-InsightHeaders

        $RequestBody = @{
            'name' = $Name
            'iconId'   = $iconID
            'objectSchemaId'   = $objectSchemaId
            }
            if ($Description) {
                $RequestBody.Add('description', $Description)
            }
            if ($parentObjectTypeId) {
                $RequestBody.Add('parentObjectTypeId', $parentObjectTypeId)
            }
            if ($Inherited -eq $true) {
                $RequestBody.Add('inherited', $Inherited)
            }
            if ($AbstractObjectType -eq $true) {
                $RequestBody.Add('abstractObjectType', $AbstractObjectType)
            }

        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objecttype/create"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -body $RequestBody -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}