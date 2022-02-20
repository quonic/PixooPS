function Set-ScoreBoard {
    <#
    .SYNOPSIS
    Controls the scoreboard on a Pixoo64 device

    .DESCRIPTION
    Controls the scoreboard on a Pixoo64 device

    .PARAMETER BlueScore
    Sets the blue score

    .PARAMETER RedScore
    Sets the red score

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-ScoreBoard

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [ValidateRange(0, 999)]
        [Alias("Blue", "b")]
        [int]
        $BlueScore = 0,
        [Parameter()]
        [ValidateRange(0, 999)]
        [Alias("Red", "r")]
        [int]
        $RedScore = 0,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command   = "Tools/SetScoreBoard"
            BlueScore = $BlueScore
            RedScore  = $RedScore
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Blue to $BlueScore and Red to $RedScore")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set countdown, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
