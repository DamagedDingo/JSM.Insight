Function Get-InsightCreds {
    [CmdletBinding()]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    param(
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [Alias('user')]
        [string]$Username,
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [Alias('pass')]
        [string]$Password
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        #Encode Creds
        $auth = $username + ':' + $password
        $Encoded = [System.Text.Encoding]::UTF8.GetBytes($auth)
        $authorizationInfo = [System.Convert]::ToBase64String($Encoded)
        $Script:InsightCreds = $authorizationInfo
    }

    end {
        $authorizationInfo
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}