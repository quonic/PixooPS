function Get-FaceList {
    <#
    .SYNOPSIS
    Get a list of faces from Divoom

    .DESCRIPTION
    Get a list of faces from Divoom

    .PARAMETER Type
    The type of face to get from Divoom. Defaults to normal

    .PARAMETER Page
    The page number. Defaults to 1.

    .EXAMPLE
    Get-FaceList

    .EXAMPLE
    Get-FaceList -Type Social

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet("Social", "normal", "financial", "Game", "HOLIDAYS", "TOOLS")]
        $Type = "normal",
        [Parameter()]
        [ValidateRange(1, 30)]
        $Page = 1
    )
    process {
        $Url = "https://app.divoom-gz.com/Channel/GetDialList"
        $Body = [PSCustomObject]@{
            DialType = $Type
            Page     = $Page
        } | ConvertTo-Json -Compress
        $ret = Invoke-RestMethod -Method Post -Uri $Url -Body $Body
        if ($ret.ReturnCode -eq 0) {
            return $ret.DialList
        }
    }
}
