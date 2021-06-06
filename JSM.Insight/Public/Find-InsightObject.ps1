function Find-InsightObject {
    [CmdletBinding()]
    param (
        [string]$IQL,
        [string]$objectTypeId,
        [int]$page = 1,
        [int]$resultsPerPage = 2000,
        [int]$orderByTypeAttrId,
        [ValidateSet(0,1)]
        [int]$asc = 1,
        [string]$objectId,
        [string]$objectSchemaId,
        [bool]$includeAttributes,
        [array]$attributesToDisplay,
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
            'iql' = $iql
            'objectTypeId'   = $objectTypeId
            'resultsPerPage' = $resultsPerPage
            }
            if ($page) {
                $RequestBody.Add('page', $page)
            }
            if ($orderByTypeAttrId) {
                $RequestBody.Add('orderByTypeAttrId', $orderByTypeAttrId)
            }
            if ($asc) {
                $RequestBody.Add('asc', $asc)
            }
            if ($objectId) {
                $RequestBody.Add('objectId', $objectId)
            }
            if ($objectSchemaId) {
                $RequestBody.Add('objectSchemaId', $objectSchemaId)
            }
            if ($includeAttributes) {
                $RequestBody.Add('includeAttributes', $includeAttributes)
            }
            if ($attributesToDisplay ) {
                $RequestBody.Add('attributesToDisplay', $attributesToDisplay)
            }

        $RequestBody = $RequestBody | ConvertTo-Json -Depth 5

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkspaceID/v$Version/object/navlist/iql"
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