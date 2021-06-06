# https://developer.atlassian.com/cloud/insight/rest/api-group-config/#api-config-statustype-get
function Get-InsightStatusTypes {
    [CmdletBinding()]
    param (
        [string]$objectSchemaId,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        if ($objectSchemaId) {
            $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/config/statustype/?objectSchemaId=$objectSchemaId"
        }
        else {
            $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/config/statustype/"
        }
    }
    
    end {
        Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method GET
    }
}