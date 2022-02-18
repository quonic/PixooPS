function Set-Screen {
    <#
    .SYNOPSIS
    Turns off and on the screen of a Pixoo64 device

    .DESCRIPTION
    Turns off and on the screen of a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .PARAMETER On
    Used to turn on the screen

    .PARAMETER Off
    Used to turn off the screen

    .EXAMPLE
    Set-Screen -On

    .EXAMPLE
    Set-Screen -Off

    .NOTES
    General notes
    #>
    param (
        [Parameter()]
        [string]
        $DeviceIP,
        [Parameter(Mandatory, ParameterSetName = "On")]
        [switch]
        $On,
        [Parameter(Mandatory, ParameterSetName = "Off")]
        [switch]
        $Off
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }
        $Body = [PSCustomObject]@{
            Command = "Channel/OnOffScreen"
            OnOff   = if ($On) { 1 }elseif ($Off) { 0 }else { throw "On and Off not specified?!" }
        } | ConvertTo-Json -Compress
        $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
        if ($res.error_code -eq 1) {
            throw "Pixoo64 returned error_code of $($res.error_code)"
        }
    }
}
