InModuleScope PixooPS {
    Describe "Test Find-Pixoo" {
        Context "Known IP Address" {
            Find-Pixoo -IPAddress $env:PixooIP | Should -BeLike $env:PixooIP
        }
        Context "Unknown IP Address" {
            Find-Pixoo | Should -BeLike $env:PixooIP
        }
    }
    Describe "Test Get-Channel" {
        Context "Get-Channel" {
            Get-Channel -DeviceIP $env:PixooIP | Should -BeLike "Cloud Channel"
        }
    }
    Describe "Test Get-Face" {
        Context "Get-Face" {
            $Resutls = Get-Face -DeviceIP $env:PixooIP
            $Resutls.ClockId | Should -BeExactly 12
            $Resutls.Brightness | Should -BeExactly 100
        }
    }
    Describe "Test Get-FaceList" {
        Context "Get-FaceList" {
            Get-FaceList -DeviceIP $env:PixooIP | Should -BeNullOrEmpty
        }
    } -Skip # Actual data may change over time, skipping
    Describe "Test Get-FaceType" {
        Context "Get-FaceType" {
            Get-FaceType -DeviceIP $env:PixooIP | Should -BeNullOrEmpty
        }
    } -Skip # Actual data may change over time, skipping
    Describe "Test Get-PixooSetting" {
        Context "Get-PixooSetting" {
            $Resutls = Get-PixooSetting -DeviceIP $env:PixooIP
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
            Invoke-PlayGif -DeviceIP $env:PixooIP -UrlGif "http://$env:PixooIP/test.gif" | Should -Be $true
        }
    }
    Describe "Test Reset-CountDown" {
        Context "Reset-CountDown" {
            Reset-CountDown -DeviceIP $env:PixooIP | Should -Be $true
        }
    }
    Describe "Test Set-Brightness" {
        Context "Set-Brightness" {
            Set-Brightness -DeviceIP $env:PixooIP -Brightness 100 | Should -Be $true
        }
    }
    Describe "Test Set-Channel" {
        Context "Set-Channel" {
            Set-Channel -DeviceIP $env:PixooIP -Channel Cloud | Should -Be $true
        }
    }
    Describe "Test Set-CloudChannel" {
        Context "Set-CloudChannel" {
            Set-CloudChannel -DeviceIP $env:PixooIP -Channel 0 | Should -Be $true
        }
    }
    Describe "Test Set-CustomPage" {
        Context "Set-CustomPage" {
            Set-CustomPage -DeviceIP $env:PixooIP -Page 0 | Should -Be $true
        }
    }
    Describe "Test Set-Face" {
        Context "Set-Face" {
            Set-Face -DeviceIP $env:PixooIP -FaceId 52 | Should -Be $true
        }
    }
    Describe "Test Set-Noise" {
        Context "Set-Noise" {
            Set-Noise -DeviceIP $env:PixooIP -On | Should -Be $true
            Set-Noise -DeviceIP $env:PixooIP -Off | Should -Be $true
        }
    }
    Describe "Test Set-PixooLocation" {
        Context "Set-PixooLocation" {
            Set-PixooLocation -DeviceIP $env:PixooIP -Latitude 0 -Longitude 0 | Should -Be $true
        }
    }
    Describe "Test Set-PixooTime" {
        Context "Set-PixooTime" {
            Set-PixooTime -DeviceIP $env:PixooIP -Date $(Get-Date) | Should -Be $true
        }
    }
    Describe "Test Set-PixooTimeZone" {
        Context "Set-PixooTimeZone" {
            Set-PixooTimeZone -DeviceIP $env:PixooIP -TimeZone "GMT-5" | Should -Be $true
            Set-PixooTimeZone -DeviceIP $env:PixooIP -TimeZone "GMT+5" | Should -Be $true
            Set-PixooTimeZone -DeviceIP $env:PixooIP -TimeZone "bad" | Should -Be $false
        }
    }
    Describe "Test Set-ScoreBoard" {
        Context "Set-ScoreBoard" {
            Set-ScoreBoard -DeviceIP $env:PixooIP -BlueScore 1 -RedScore 1 | Should -Be $true
        }
    }
    Describe "Test Set-Screen" {
        Context "Set-Screen" {
            Set-Screen -DeviceIP $env:PixooIP -On | Should -Be $true
            Set-Screen -DeviceIP $env:PixooIP -Off | Should -Be $true
        }
    }
    Describe "Test Set-Visualizer" {
        Context "Set-Visualizer" {
            Set-Visualizer -DeviceIP $env:PixooIP -EqPosition 1 | Should -Be $true
        }
    }
    Describe "Test Start-CountDown" {
        Context "Start-CountDown" {
            Start-CountDown -DeviceIP $env:PixooIP -Hours 1 -Minutes 10 -Seconds 10 | Should -Be $true
        }
    }
    Describe "Test Stop-CountDown" {
        Context "Stop-CountDown" {
            Stop-CountDown -DeviceIP $env:PixooIP | Should -Be $true
        }
    }


}
