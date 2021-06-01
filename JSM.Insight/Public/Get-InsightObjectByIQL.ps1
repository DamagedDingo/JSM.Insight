# https://developer.atlassian.com/cloud/insight/rest/api-group-icon/#api-icon-id-get
function Get-InsightObjectByIQL {
    [CmdletBinding()]
    param (
        [String]$Version = "1",
        [string]$IQL,
        [int]$page,
        [int]$resultsPerPage = 25,
        [bool]$includeAttributes,
        [int]$includeAttributesDeep = 1,
        [bool]$includeTypeAttributes,
        [bool]$includeExtendedInfo,
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders

        $RequestBody = @{
            'resultsPerPage' = $resultsPerPage
            }
        if ($IQL) {
            $RequestBody.Add("iql",$iql )
        }
        if ($page) {
            $RequestBody.Add("page",$page )
        }
        if ($includeAttributes) {
            $RequestBody.Add("includeAttributes",$includeAttributes )
        }
        if ($includeAttributesDeep) {
            $RequestBody.Add("includeAttributesDeep",$includeAttributesDeep )
        }
        if ($includeTypeAttributes) {
            $RequestBody.Add("includeTypeAttributes",$includeTypeAttributes )
        }
        if ($includeExtendedInfo) {
            $RequestBody.Add("includeExtendedInfo",$includeExtendedInfo )
        }
        
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1
        Write-Verbose $RequestBody
    }
    
    process {
        # Default is Global which will show all icons.
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/iql/objects"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}