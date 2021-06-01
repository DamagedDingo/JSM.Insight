# https://developer.atlassian.com/cloud/insight/rest/api-group-config/#api-config-statustype-id-put
function Set-InsightStatusType {
    [CmdletBinding()]
    param (
        [String]$ID,
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
            "InActive\Red" { 0 }
            "Active\Green" { 1 }
            "Pending\Yellow" { 2 }
        }

        $RequestBody = @{
            'name' = $Name
            'category'   = $Category
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
        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/config/statustype/$ID"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method PUT
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}