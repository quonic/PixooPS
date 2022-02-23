Properties {
    # Pester can build the module using both scenarios
    if (Test-Path -Path 'Variable:\PSBuildCompile') {
        $PSBPreference.Build.CompileModule = $global:PSBuildCompile
    } else {
        $PSBPreference.Build.CompileModule = $true
    }
    # Set this to $true to create a module with a monolithic PSM1
    # $PSBPreference.Build.CompileModule = $false
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.ImportModule = $true
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
}

Task Default -depends Test

Task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'
