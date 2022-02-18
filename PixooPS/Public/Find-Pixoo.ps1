function Find-Pixoo {
    <#
    .SYNOPSIS
    Finds the IP address of any Pixoo64 device on the local network

    .DESCRIPTION
    Finds the IP address of any Pixoo64 device on the local network

    .PARAMETER IPAddress
    Specify only if you already know what the IP address is
    Can also be used to verify that the specified IP address is a Pixoo64 device

    .EXAMPLE
    Find-Pixoo

    .NOTES
    General notes
    #>
    param(
        $IPAddress
    )
    begin {
        function Get-PixooIP {
            $network = (
                (
                    Get-NetIPInterface -ConnectionState Connected -AddressFamily IPv4 -Dhcp Enabled |
                    Get-NetIPAddress
                ).IPAddress -split '\.'
            )[0..2] -join '.'
            (Get-NetNeighbor | Where-Object { $_.IPAddress -like "$network*" -and $_.LinkLayerAddress -like "7C-87-CE*" }).IPAddress
        }
    }
    process {
        if ($IPAddress) {
            $get = Invoke-RestMethod -Uri "http://$IPAddress/get"
            if ($get -like "*Hello World divoom!*") {
                $IPAddress
            }
        } else {
            $IPs = Get-PixooIP
            if ($IPs.Count -eq 0) {
                1..254 | ForEach-Object {
                    $(($network -split '\.')[0..2])
                    Test-Connection -Ping -Count 1 -TimeoutSeconds 1 -IPv4 -TargetName "$(($network -split '\.')[0..2]).$_"
                }
                $IPs = Get-PixooIP
                if ($IPs.Count -eq 0) {
                    throw "Pixoo64 not found on network"
                }
            }
            foreach ($ip in $IPs) {
                try {
                    $get = Invoke-RestMethod -Uri "http://$Ip/get"
                    if ($get -like "*Hello World divoom!*") {
                        $Ip
                    }
                    break
                } catch {
                    Write-Error $Error[0]
                }
            }
        }
    }
}
