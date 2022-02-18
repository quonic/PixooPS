function Set-Channel {
    <#
    .SYNOPSIS
    Sets the Channel of a Pixoo64 device

    .DESCRIPTION
    Sets the Channel of a Pixoo64 device

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .PARAMETER Channel
    The channel that you want

    .EXAMPLE
    Set-Channel -Channel Faces

    .EXAMPLE
    Set-Channel -Channel Visualizer

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([boolean])]
    param(
        [Parameter()]
        [string]
        $DeviceIP,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Faces", "Cloud", "Visualizer", "Custom")]
        [String]
        $Channel
    )
    begin {
        $Index = if ($Channel -eq "Faces") {
            0
        } elseif ($Channel -eq "Cloud") {
            1
        } elseif ($Channel -eq "Visualizer") {
            2
        } elseif ($Channel -eq "Custom") {
            3
        } else {
            Write-Error "Invalid channel"
        }
    }
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }
        $Body = [PSCustomObject]@{
            Command     = "Channel/SetIndex"
            SelectIndex = $Index
        } | ConvertTo-Json -Compress
        if ($PSCmdlet.ShouldProcess("$DeviceIP", "Set Channel to $Index")) {
            $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
            if ($res.error_code -and $res.error_code -eq 0) {
                Write-Verbose "Success"
                return $true
            } else {
                Write-Error "Failed to set channel"
                return $false
            }
        }
        return $false
    }
}
