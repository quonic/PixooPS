function Set-Brightness {
    <#
    .SYNOPSIS
    Sets the Brightness of a Pixoo64 device

    .DESCRIPTION
    Sets the Brightness of a Pixoo64 device.

    .PARAMETER Brightness
    The Brightness that you wish a Pixoo64 device to be set to, rangine from 0 to 100

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-Brightness -Brightness 0

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 100)]
        [int]
        $Brightness,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command    = "Channel/SetBrightness"
            Brightness = $Brightness
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Brightness to $Brightness")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set Brightness, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
