function Set-Location {
    <#
    .SYNOPSIS
    Sets the Latitude and Longitude Location of a Pixoo64 device for it to get weather information

    .DESCRIPTION
    Sets the Latitude and Longitude Location of a Pixoo64 device for it to get weather information

    .PARAMETER Latitude
    The Latitude of a Pixoo64 device

    .PARAMETER Longitude
    The Longitude of a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-Location -Latitude 0 -Longitude 0

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(-90, 90)]
        [Alias("lat", "lt")]
        [Single]
        $Latitude,
        [Parameter(Mandatory = $true)]
        [ValidateRange(-180, 180)]
        [Alias("long", "lng", "lon", "ln")]
        [Single]
        $Longitude,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command   = "Sys/LogAndLat"
            Latitude  = $Latitude
            Longitude = $Longitude
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set LogAndLat to $Latitude,$Longitude")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set LogAndLat, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
