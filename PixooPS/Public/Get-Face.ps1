function Get-Face {
    <#
    .SYNOPSIS
    Gets the current face of a Pixoo64 device

    .DESCRIPTION
    Gets the current face of a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Get-Face

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command = "Channel/GetClockInfo"
        } | ConvertTo-Json -Compress

        $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
        if ($res) {
            Write-Verbose "Success"
            return $ret
        } else {
            Write-Error "Failed to set Face, Error: $($res.error_code)"
            return $false
        }
    }
}
