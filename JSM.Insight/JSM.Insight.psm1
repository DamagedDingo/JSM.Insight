$Public  = @(Get-ChildItem -Path "$PSScriptRoot\Public\" -include '*.ps1' -recurse -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path "$PSScriptRoot\Private\" -include '*.ps1' -recurse -ErrorAction SilentlyContinue)

foreach ($ImportedFunction in @($Public + $Private)) {
    try {
        . $ImportedFunction.fullname
    } catch {
        Write-Error -Message "Failed to import function $($ImportedFunction.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
