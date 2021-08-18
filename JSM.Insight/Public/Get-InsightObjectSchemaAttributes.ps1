
function Get-InsightObjectSchemaAttributes {
    [CmdletBinding()]
    param (
        [string]$ID,
        [bool]$onlyValueEditable = $False,
        [bool]$extended = $False,
        [string]$Query,
        [String]$Version = '1',
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders
    }
    
    process {
        $RequestBody = @{
            }
            if ($onlyValueEditable) {
                $RequestBody.Add('onlyValueEditable',$onlyValueEditable)
            }
            if ($extended) {
                $RequestBody.Add('extended',$extended)
            }
            if ($Query) {
                $RequestBody.Add('query',$Query)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/objectschema/$id/attributes"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -ErrorRecord $_
        } 

        $response
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}