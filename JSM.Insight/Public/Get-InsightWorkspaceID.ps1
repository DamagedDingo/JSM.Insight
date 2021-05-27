
function Get-InsightWorkspaceID {
    [CmdletBinding()]
    param (
        [uri]$InsightServerUrl,
        [string]$InsightCreds = $InsightCreds
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-Headers -ExperimentalApi
    }
    
    process {
        $Request = [System.UriBuilder]"$InsightServerUrl/rest/servicedeskapi/insight/workspace"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
        } 
        $script:InsightWorkspaceID = $response.values.workspaceId
        $response.values.workspaceId

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
