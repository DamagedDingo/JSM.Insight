
function Get-WorkspaceID {
    param (
        [cmdletbinding()]
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
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 
        $script:InsightWorkstationID = $response.values.workspaceId
        $response.values.workspaceId

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
