function Set-PixooTimeZone {
    <#
    .SYNOPSIS
    Sets the TimeZone of a Pixoo64 device

    .DESCRIPTION
    Sets the TimeZone of a Pixoo64 device.

    .PARAMETER TimeZone
    The TimeZone that you wish a Pixoo64 device to be set to. Must be in the GMT format, like GMT-5/GMT+1

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-PixooTimeZone -TimeZone "GMT-5"

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 100)]
        [string]
        $TimeZone,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command    = "Sys/TimeZone"
            TimeZoneValue = $TimeZone
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set TimeZone to $TimeZone")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set TimeZone, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
