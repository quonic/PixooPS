function Start-CountDown {
    <#
    .SYNOPSIS
    Start a count down timer on a Pixoo64 device

    .DESCRIPTION
    Start a count down timer on a Pixoo64 device

    .PARAMETER Hours
    How many hours the count down should last

    .PARAMETER Minutes
    How many minutes the count down should last

    .PARAMETER Seconds
    How many seconds the count down should last

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Start-CountDown

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [int]
        $Hours = 0,
        [Parameter()]
        [int]
        $Minutes = 1,
        [Parameter()]
        [int]
        $Seconds = 0,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Minutes = if ($Hours -gt 1) {
            ($Hours * 60) + $Minutes
        } else {
            $Minutes
        }

        $Body = [PSCustomObject]@{
            Command = "Tools/SetTimer"
            Minute  = $Minutes
            Second  = $Seconds
            Status  = 1
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Minutes to $Minutes and Seconds to $Seconds")) {
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
