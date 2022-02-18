function Get-Channel {
    <#
    .SYNOPSIS
    Returns what channel a Pixoo64 device is currently on

    .DESCRIPTION
    Returns what channel a Pixoo64 device is currently on

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    Get-Channel

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
            Command = "Channel/GetIndex"
        } | ConvertTo-Json -Compress

        $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
        if (($res.error_code -eq 0) -or $res.SelectIndex) {
            Write-Verbose "Success"
            $ret = switch ($res.SelectIndex) {
                0 { "Faces" }
                1 { "Cloud Channel" }
                2 { "Visualizer" }
                3 { "Custom" }
                Default { "Error" }
            }
            return $ret
        } else {
            Write-Error "Failed to get channel, Error: $($res.error_code)"
            return $false
        }
    }
}
