function Get-PixooSetting {
    <#
    .SYNOPSIS
    Gets the settings of a Pixoo64 device

    .DESCRIPTION
    Gets the settings of a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Get-PixooSetting

    .NOTES
    General notes
    #>
    [OutputType([PSObject])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command = "Channel/GetAllConf"
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Get settings from device")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to get settings, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
