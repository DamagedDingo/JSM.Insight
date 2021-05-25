
function Get-ObjectSchemaAttributes {
    [CmdletBinding()]
    param (
        [string]$ID,
        [bool]$onlyValueEditable = $False,
        [bool]$extended = $False,
        [string]$Query,
        [String]$Version = '1',
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkstationID = $InsightWorkstationID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-Headers
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
                $RequestBody.Add('Query',$Query)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkstationID/v$Version/objectschema/$id/attributes"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method GET
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}