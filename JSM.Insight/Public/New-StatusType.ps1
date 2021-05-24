# https://developer.atlassian.com/cloud/insight/rest/api-group-config/#api-config-statustype-post
function New-StatusType {
    [CmdletBinding()]
    param (
        [String]$Name,
        [String]$Description,
        [ValidateSet("InActive\Red","Active\Green","Pending\Yellow")]
        [String]$Category,
        [String]$objectSchemaId,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkstationID = $InsightWorkstationID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        switch ($Category) {
            "InActive\Red" { 0 }
            "Active\Green" { 1 }
            "Pending\Yellow" { 2 }
        }

        $RequestBody = @{
            'name' = $Name
            'Category'   = $Category
            }
            if ($Description) {
                $RequestBody.Add('Description', $Description)
            }
            if ($objectSchemaId) {
                $RequestBody.Add('objectSchemaId', $objectSchemaId)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1

        $Headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
        $Headers.Add('content-type' , 'application/json')
        $Headers.Add('Authorization', 'Basic ' + $InsightCreds)
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkstationID/v$Version/config/statustype"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method POST
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}