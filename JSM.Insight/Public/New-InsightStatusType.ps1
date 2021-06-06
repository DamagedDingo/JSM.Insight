# https://developer.atlassian.com/cloud/insight/rest/api-group-config/#api-config-statustype-post
function New-InsightStatusType {
    [CmdletBinding()]
    param (
        [String]$Name,
        [String]$Description,
        [ValidateSet("InActive\Red","Active\Green","Pending\Yellow")]
        [String]$Category,
        [String]$objectSchemaId,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkspaceID = $InsightWorkspaceID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        $Headers = New-InsightHeaders

        switch ($Category) {
            "InActive\Red" { $CategoryID = 0 }
            "Active\Green" { $CategoryID = 1 }
            "Pending\Yellow" { $CategoryID = 2 }
        }

        $RequestBody = @{
            'name' = $Name
            'category'   = $CategoryID
            }
            if ($Description) {
                $RequestBody.Add('description', $Description)
            }
            if ($objectSchemaId) {
                $RequestBody.Add('objectSchemaId', $objectSchemaId)
            }
        $RequestBody = ConvertTo-Json $RequestBody -Depth 1
    }
    
    process {
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/config/statustype"
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