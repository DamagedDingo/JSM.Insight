

# API Docs need info on how to add Query parameters. 
# https://developer.atlassian.com/cloud/insight/rest/api-group-objecttype/#api-objecttype-id-attributes-get

function Get-InsightObjectTypeAttributes {
    [CmdletBinding()]
    param (
        [string]$ID,
        [switch]$onlyValueEditable,
        [switch]$orderByName,
        [string]$query,
        [switch]$includeValuesExist,
        [switch]$excludeParentAttributes,
        [switch]$includeChildren,
        [switch]$orderByRequired,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objecttype/$id/attributes"
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