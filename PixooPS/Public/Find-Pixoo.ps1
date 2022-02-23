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
            if ($env:PixooIP -and (Test-Connection -TargetName $env:PixooIP -Ping -IPv4 -Count 1 -TimeoutSeconds 1 -Quiet)) {
                return $env:PixooIP
            }
            $network = (
                (
                    Get-NetIPInterface -ConnectionState Connected -AddressFamily IPv4 -Dhcp Enabled |
                    Get-NetIPAddress
                ).IPAddress -split '\.'
            )[0..2] -join '.'
            $IPList = (Get-NetNeighbor | Where-Object { $_.IPAddress -like "$network*" -and $_.LinkLayerAddress -like "7C-87-CE*" }).IPAddress
            if ($IPList.Count -eq 0) {
                1..254 | ForEach-Object {
                    Test-Connection -Ping -Count 1 -TimeoutSeconds 1 -IPv4 -TargetName "$(($network -split '\.')[0..2] -join '.').$_" -Quiet | Out-Null
                }
                return $(Get-NetNeighbor | Where-Object { $_.IPAddress -like "$network*" -and $_.LinkLayerAddress -like "7C-87-CE*" }).IPAddress
            }else{
                return $IPList
            }
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
                throw "Pixoo64 not found on network"
            }
            foreach ($Ip in $IPs) {
                try {
                    $get = Invoke-RestMethod -Uri "http://$Ip/get"
                    if ($get -like "*Hello World divoom!*") {
                        $env:PixooIP = $Ip
                        Write-Information "Pixoo64 found on network at $Ip"
                    }
                    break
                } catch {
                    Write-Information "Pixoo64 not found on network at $Ip"
                }
            }
        }
    }
}
