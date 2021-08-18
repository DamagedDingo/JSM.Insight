function New-InsightObject {
    [CmdletBinding()]
    param (
        [string]$objectTypeId,
        [array]$attributesArray,
        [Bool]$hasAvatar,
        [string]$avatarUUID,
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
            'objectTypeId' = $objectTypeId
            'attributes'   = @($attributesArray)
            }

        $RequestBody = $RequestBody | ConvertTo-Json -Depth 5

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/object/create"
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