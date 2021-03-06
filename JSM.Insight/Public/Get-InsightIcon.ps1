# https://developer.atlassian.com/cloud/insight/rest/api-group-icon/#api-icon-id-get
function Get-InsightIcon {
    [CmdletBinding()]
    param (
        [String]$Version = "1",
        [string]$IconID = "global",
        [switch]$Full,
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        # Default is Global which will show all icons.
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/icon/$IconID"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -ErrorRecord $_
        } 

        if ($Full -eq $true) {
            $response
        }
        else {
            $response | Select id,name
        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}