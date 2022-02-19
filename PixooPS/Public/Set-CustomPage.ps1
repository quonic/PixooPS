function Set-CustomPage {
    <#
    .SYNOPSIS
    Sets the custom page of a Pixoo64 device

    .DESCRIPTION
    Sets the custom page of a Pixoo64 device, similar to Set-Face.

    .PARAMETER Page
    The custom index that you wish a Pixoo64 device to be set to, ranging from 0 to 2

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Set-CustomPage -Page 0

    .NOTES
    General notes
    #>
    [OutputType([boolean])]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 2)]
        [int]
        $Page,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command         = "Channel/SetCustomPageIndex"
            CustomPageIndex = $Page
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set custom page to $Page")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set custom page, Error: $($res.error_code)"
                return $false
            }
        }
        return $false
    }
}
