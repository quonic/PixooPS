function Set-Visualizer {
    <#
    .SYNOPSIS
    Sets the Visualizer of a Pixoo64 device

    .DESCRIPTION
    Sets the Visualizer of a Pixoo64 device, similar to Set-Face.

    .PARAMETER EqPosition
    The Eq Position that you wish a Pixoo64 device to be set to, 0 or greater

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-Visualizer -EqPosition 0

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [int]
        $EqPosition,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command    = "Channel/SetEqPosition"
            EqPosition = $EqPosition
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set EqPosition to $EqPosition")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set EqPosition, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
