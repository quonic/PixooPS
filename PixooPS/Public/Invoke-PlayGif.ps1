function Invoke-PlayGif {
    <#
    .SYNOPSIS
    Sends a link to a gif, from an http site, to a Pixoo64 device.

    .DESCRIPTION
    Sends a link to a gif, from an http site, to a Pixoo64 device.

    .PARAMETER DeviceIP
    The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

    .PARAMETER UrlGif
    An http url that points to a gif

    .EXAMPLE
    Invoke-PlayGif -Url "http://example.com/MyAnimation.gif"

    .NOTES
    General notes
    #>
    [OutputType([Boolean])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]
        $DeviceIP,
        [Parameter(Mandatory = $true)]
        [string]
        $UrlGif
    )
    process {
        if (-not $DeviceIP) {
            $DeviceIP = Find-Pixoo | Select-Object -First 1
        }
        if ($UrlGif -like "http://*") {
            $get = Invoke-RestMethod -Uri "http://$DeviceIP/get"
            if ($get -like "*Hello World divoom!*") {
                $Body = [PSCustomObject]@{
                    Command  = "Device/PlayTFGif"
                    FileType = 2
                    FileName = $UrlGif
                } | ConvertTo-Json -Compress

                $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
                if ($res.error_code -and $res.error_code -eq 0) {
                    Write-Verbose "Success"
                    $Body = [PSCustomObject]@{
                        Command = "Draw/GetHttpGifId"
                    } | ConvertTo-Json -Compress

                    $res = Invoke-RestMethod -Method Post -Uri "http://$DeviceIP/post" -Body $Body
                    if ($res.error_code -and $res.error_code -eq 0) {
                        $res.PicId

                        Write-Verbose "Success"
                        return $true
                        # Don't know if this is needed
                        # Set-Channel -DeviceIP "192.168.1.199" -Channel Cloud
                    }
                } else {
                    Write-Error "Failed to send gif to $DeviceIP."
                    return $false
                }
            } else {
                Write-Error "Device not found. Please check the IP address."
                return $false
            }
        } else {
            Write-Error "Invalid url: https isn't supported."
            return $false
        }
    }
}
