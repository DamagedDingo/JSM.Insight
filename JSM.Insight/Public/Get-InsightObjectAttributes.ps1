# https://developer.atlassian.com/cloud/insight/rest/api-group-object/#api-object-id-attributes-get
function Get-InsightObjectAttributes {
    [CmdletBinding()]
    param (
        [string]$ID,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/object/$id/attributes"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
			Write-Error -ErrorRecord $_
        } 

        $response
        
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}