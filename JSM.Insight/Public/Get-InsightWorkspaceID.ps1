
function Get-InsightWorkspaceID {
    [CmdletBinding()]
    param (
        [string]$InsightServerUrl,
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

            $script:InsightWorkspaceID = $response.values.workspaceId
            $response.values.workspaceId
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
        } 
        
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
