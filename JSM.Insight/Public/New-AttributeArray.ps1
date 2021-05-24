function New-AttributeArray {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $true,valuefrompipelinebypropertyname = $true)]
        [int]$AttributeId,

        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $true,valuefrompipelinebypropertyname = $true)]
        [String[]]$AttributeValues
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $values = New-Object System.Collections.ArrayList 
    }
    
    process {
        $AttributeValues | ForEach-Object {
            $values.Add(@{'value' = $_}) | Out-Null
        }        
        $Attribute = @{
            'objectTypeAttributeId' = $AttributeId
            'objectAttributeValues'   = @($values)
            }
    }

    end {
        Write-Output $Attribute
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
        }
}


