function Set-CloudChannel {
    <#
    .SYNOPSIS
    Sets the Cloud Channel of a Pixoo64 device

    .DESCRIPTION
    Sets the Cloud Channel of a Pixoo64 device, similar to Set-Face.

    .PARAMETER Channel
    The Eq Position that you wish a Pixoo64 device to be set to, 0 or greater.
    0: Recommended Gallery, 1: Favourite, 2: Subscribed Artists

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-CloudChannel -EqPosition 0

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 2)]
        [int]
        $Channel,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command    = "Channel/CloudIndex"
            Index   = $Channel
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Cloud Channel to $Channel")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set Cloud Channel, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
