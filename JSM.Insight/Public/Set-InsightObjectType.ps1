
function Set-InsightObjectType {
    [CmdletBinding()]
    param (
        [string]$ID,
        [string]$name,
        [string]$description,
        [string]$iconID,
        [string]$ObjectSchemaID,
        [string]$ParentObjectTypeID,
        [bool]$Inherited,
        [string]$AbstractObjectType,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders

        $RequestBody = @{
            'name' = $Name
            'iconID'   = $iconID
            'objectSchemaId'   = $objectSchemaId
            }
            if ($Description) {
                $RequestBody.Add('description', $Description)
            }
            if ($parentObjectTypeId) {
                $RequestBody.Add('parentObjectTypeId', $parentObjectTypeId)
            }
            if ($Inherited) {
                $RequestBody.Add('inherited', $Inherited)
            }
            if ($AbstractObjectType) {
                $RequestBody.Add('abstractObjectType', $AbstractObjectType)
            }

        $RequestBody = ConvertTo-Json $RequestBody -Depth 1
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objecttype/$id"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method PUT
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -ErrorRecord $_
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}