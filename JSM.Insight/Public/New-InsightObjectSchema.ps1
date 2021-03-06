
function New-InsightObjectSchema {
    [CmdletBinding()]
    param (
        [string]$Name,
        [string]$objectSchemaKey,
        [string]$Description,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        $RequestBody = @{
            'name' = $Name
            'objectSchemaKey'   = $objectSchemaKey
            }
            if ($Description) {
                $RequestBody.Add('description', $Description)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objectschema/create"
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