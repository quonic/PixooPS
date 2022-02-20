function Stop-CountDown {
    <#
    .SYNOPSIS
    Stop a count down timer on a Pixoo64 device

    .DESCRIPTION
    Stop a count down timer on a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Stop-CountDown

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
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
            Command = "Tools/SetStopWatch"
            Status  = 0
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Stops the countdown timer")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to stop countdown, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
