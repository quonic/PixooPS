InModuleScope PixooPS {
    BeforeAll {
        $DeviceIP = if (
            [String]::IsNullOrWhiteSpace($env:PixooIP) -and
            [String]::IsNullOrEmpty($env:PixooIP) -and
            (Test-Connection -TargetName $env:PixooIP -Ping -IPv4 -Count 1)
        ) {
            $env:PixooIP
        } else {
            $MockServerIP = "72.14.184.84"
            if ((Test-Connection -TargetName $MockServerIP -Ping -IPv4 -Count 1)) {
                $MockServerIP
            } else {
                Write-Error "Not able to connect to Mock API Server."
                Exec { cmd /c exit (1) }
            }
        }
        # Check if cmdlets exist, if not create them for mocking.
        if ((Get-Command "Get-NetIPInterface").Count -eq 0) { function Get-NetIPInterface { param () } }
        if ((Get-Command "Get-NetIPAddress").Count -eq 0) { function Get-NetIPAddress { param () } }
        Mock Test-Connection {
            return $true
        }
        Mock Get-NetIPInterface {
            return $true
        }
        Mock Get-NetIPAddress {
            return [PSCustomObject]@{
                IPAddress = $DeviceIP
            }
        }
    }

    Describe "Test Find-Pixoo" {
        Context "Known IP Address" {
            Find-Pixoo -IPAddress $DeviceIP | Should -BeLike $DeviceIP
        }
        Context "Unknown IP Address" {
            Find-Pixoo | Should -BeLike $DeviceIP
        } -Skip # Have to manually test this
    }
    Describe "Test Get-Channel" {
        Context "Get-Channel" {
            Get-Channel -DeviceIP $DeviceIP | Should -BeLike "Cloud Channel"
        }
    }
    Describe "Test Get-Face" {
        Context "Get-Face" {
            $Resutls = Get-Face -DeviceIP $DeviceIP
            $Resutls.ClockId | Should -BeExactly 12
            $Resutls.Brightness | Should -BeExactly 100
        }
    }
    Describe "Test Get-FaceList" {
        Context "Get-FaceList" {
            Get-FaceList -DeviceIP $DeviceIP | Should -BeNullOrEmpty
        }
    } -Skip # Actual data may change over time, skipping
    Describe "Test Get-FaceType" {
        Context "Get-FaceType" {
            Get-FaceType -DeviceIP $DeviceIP | Should -BeNullOrEmpty
        }
    } -Skip # Actual data may change over time, skipping
    Describe "Test Get-PixooSetting" {
        Context "Get-PixooSetting" {
            $Resutls = Get-PixooSetting -DeviceIP $DeviceIP
            $Resutls.error_code | Should -BeExactly 0
            $Resutls.Brightness | Should -BeExactly 100
            $Resutls.RotationFlag | Should -BeExactly 1
            $Resutls.ClockTime | Should -BeExactly 60
            $Resutls.GalleryTime | Should -BeExactly 60
            $Resutls.SingleGalleyTime | Should -BeExactly 5
            $Resutls.PowerOnChannelId | Should -BeExactly 1
            $Resutls.GalleryShowTimeFlag | Should -BeExactly 1
            $Resutls.CurClockId | Should -BeExactly 1
            $Resutls.Time24Flag | Should -BeExactly 1
            $Resutls.TemperatureMode | Should -BeExactly 1
            $Resutls.GyrateAngle | Should -BeExactly 1
            $Resutls.MirrorFlag | Should -BeExactly 1
        }
    }
    Describe "Test Invoke-PlayGif" {
        Context "Invoke-PlayGif" {
            Invoke-PlayGif -DeviceIP $DeviceIP -UrlGif "http://$DeviceIP/test.gif" | Should -Be $true
        }
    }
    Describe "Test Reset-CountDown" {
        Context "Reset-CountDown" {
            Reset-CountDown -DeviceIP $DeviceIP | Should -Be $true
        }
    }
    Describe "Test Set-Brightness" {
        Context "Set-Brightness" {
            Set-Brightness -DeviceIP $DeviceIP -Brightness 100 | Should -Be $true
        }
    }
    Describe "Test Set-Channel" {
        Context "Set-Channel" {
            Set-Channel -DeviceIP $DeviceIP -Channel Cloud | Should -Be $true
        }
    }
    Describe "Test Set-CloudChannel" {
        Context "Set-CloudChannel" {
            Set-CloudChannel -DeviceIP $DeviceIP -Channel 0 | Should -Be $true
        }
    }
    Describe "Test Set-CustomPage" {
        Context "Set-CustomPage" {
            Set-CustomPage -DeviceIP $DeviceIP -Page 0 | Should -Be $true
        }
    }
    Describe "Test Set-Face" {
        Context "Set-Face" {
            Set-Face -DeviceIP $DeviceIP -FaceId 52 | Should -Be $true
        }
    }
    Describe "Test Set-Noise" {
        Context "Set-Noise" {
            Set-Noise -DeviceIP $DeviceIP -On | Should -Be $true
            Set-Noise -DeviceIP $DeviceIP -Off | Should -Be $true
        }
    }
    Describe "Test Set-PixooLocation" {
        Context "Set-PixooLocation" {
            Set-PixooLocation -DeviceIP $DeviceIP -Latitude 0 -Longitude 0 | Should -Be $true
        }
    }
    Describe "Test Set-PixooTime" {
        Context "Set-PixooTime" {
            Set-PixooTime -DeviceIP $DeviceIP -Date $(Get-Date) | Should -Be $true
        }
    }
    Describe "Test Set-PixooTimeZone" {
        Context "Set-PixooTimeZone" {
            Set-PixooTimeZone -DeviceIP $DeviceIP -TimeZone "GMT-5" | Should -Be $true
            Set-PixooTimeZone -DeviceIP $DeviceIP -TimeZone "GMT+5" | Should -Be $true
            Set-PixooTimeZone -DeviceIP $DeviceIP -TimeZone "bad" | Should -Be $false
        }
    }
    Describe "Test Set-ScoreBoard" {
        Context "Set-ScoreBoard" {
            Set-ScoreBoard -DeviceIP $DeviceIP -BlueScore 1 -RedScore 1 | Should -Be $true
        }
    }
    Describe "Test Set-Screen" {
        Context "Set-Screen" {
            Set-Screen -DeviceIP $DeviceIP -On | Should -Be $true
            Set-Screen -DeviceIP $DeviceIP -Off | Should -Be $true
        }
    }
    Describe "Test Set-Visualizer" {
        Context "Set-Visualizer" {
            Set-Visualizer -DeviceIP $DeviceIP -EqPosition 1 | Should -Be $true
        }
    }
    Describe "Test Start-CountDown" {
        Context "Start-CountDown" {
            Start-CountDown -DeviceIP $DeviceIP -Hours 1 -Minutes 10 -Seconds 10 | Should -Be $true
        }
    }
    Describe "Test Stop-CountDown" {
        Context "Stop-CountDown" {
            Stop-CountDown -DeviceIP $DeviceIP | Should -Be $true
        }
    }


}
