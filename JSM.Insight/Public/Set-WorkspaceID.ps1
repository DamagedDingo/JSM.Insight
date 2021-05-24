
function Set-WorkspaceID {
    param (
        [uri]$InsightServerUrl = $InsightServerUrl,
        [string]$InsightCreds = $InsightCreds
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
        $Headers.Add('content-type' , 'application/json')
        $Headers.Add('X-ExperimentalApi', 'opt-in')
        $Headers.Add('Authorization', 'Basic ' + $InsightCreds)
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

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
