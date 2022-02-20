function Set-Noise {
    <#
    .SYNOPSIS
    Set the NoiseStatus on a Pixoo64 device

    .DESCRIPTION
    Set the NoiseStatus on a Pixoo64 device

    .PARAMETER On
    Set the NoiseStatus to 1, ie On

    .PARAMETER Off
    Set the NoiseStatus to 0, ie Off

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-Noise -On

    .EXAMPLE
    Set-Noise -Off

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [switch]
        $On,
        [Parameter()]
        [switch]
        $Off,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $NoiseStatus = if($On) {
            1
        }elseif($Off){
            0
        }
        $Body = [PSCustomObject]@{
            Command = "Tools/SetNoiseStatus"
            NoiseStatus = $NoiseStatus
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set NoiseStatus to $NoiseStatus")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set NoiseStatus, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
