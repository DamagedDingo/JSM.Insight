
function Set-ObjectSchema {
    [CmdletBinding()]
    param (
        [string]$ID,
        [string]$Name,
        [string]$objectSchemaKey,
        [string]$Description,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-Headers
    }
    
    process {
        $RequestBody = @{
            'name' = $Name
            'objectSchemaKey'   = $objectSchemaKey
            }
            if ($Description) {
                $RequestBody.Add('description',$Description)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objectschema/$id"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response
        
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}