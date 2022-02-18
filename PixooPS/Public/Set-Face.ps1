function Set-Face {
    <#
    .SYNOPSIS
    Sets the face of a Pixoo64 device

    .DESCRIPTION
    Sets the face of a Pixoo64 device

    .PARAMETER FaceId
    The face id that you wish a Pixoo64 device to be set to

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .EXAMPLE
    $Face = Get-FaceList | Where-Object { $_.Name -like "Big Time" }
    Set-Face -FaceId $Face.ClockId -DeviceIP (Find-Pixoo | Select-Object -First 1)

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int]
        $FaceId,
        [string]
        $DeviceIP
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }

        $Body = [PSCustomObject]@{
            Command = "Channel/SetClockSelectId"
            ClockId = $FaceId
        } | ConvertTo-Json -Compress

        $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
        if ($res.error_code -eq 0) {
            Write-Verbose "Success"
            return $true
        } else {
            Write-Error "Failed to set Face, Error: $($res.error_code)"
            return $false
        }
    }
}
