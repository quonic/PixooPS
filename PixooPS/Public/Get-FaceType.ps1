function Get-FaceType {
    <#
    .SYNOPSIS
    Get a list of face(DialType) from Divoom

    .DESCRIPTION
    Get a list of face(DialType) from Divoom

    .EXAMPLE
    Get-FaceType

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param ()
    process {
        $Url = "https://app.divoom-gz.com/Channel/GetDialType"
        $ret = Invoke-RestMethod -Method Post -Uri $Url
        if ($ret.ReturnCode -eq 0) {
            return $ret.DialTypeList
        }
    }
}
