
function Set-InsightObjectPosition {
    [CmdletBinding()]
    param (
        [string]$ID,
        [string]$toObjectTypeId,
        [int]$position,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {

        $RequestBody = @{
            'position' = $position
            }
            if ($toObjectTypeId) {
                $RequestBody.Add('toObjectTypeId', $toObjectTypeId)
            }

        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objecttype/$id/position"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -ErrorRecord $_
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}