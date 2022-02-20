function Set-PixooTimeZone {
    <#
    .SYNOPSIS
    Sets the Date and Time of a Pixoo64 device

    .DESCRIPTION
    Sets the Date and Time of a Pixoo64 device.

    .PARAMETER Date
    The Date and Time that you wish a Pixoo64 device to be set to. Accepts a DateTime object.

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-PixooTimeZone

    .EXAMPLE
    Set-PixooTimeZone -Date (Get-Date)

    .EXAMPLE
    Get-Date | Set-PixooTimeZone

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(ValueFromPipeline)]
        [DateTime]
        $Date,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }
        if (-not $Date) {
            $Date = Get-Date
        }

        $Body = [PSCustomObject]@{
            Command = "Device/SetUTC"
            Utc     = ([DateTimeOffset]$Date).ToUnixTimeSeconds()
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Date to $Date")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set Date, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
