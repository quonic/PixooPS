$Port = 8080
$Address = "localhost"
Start-PodeServer {
    Add-PodeEndpoint -Address $Address -Port $Port -Protocol Http

    Add-PodeRoute -Method Post -Path '/post' -ScriptBlock {
        if ($WebEvent.Data -and $WebEvent.Data.Count -gt 0) {
            switch ($WebEvent.Data.Command) {
                "Channel/SetClockSelectId" {
                    if ($WebEvent.Data.ClockId -ge 0) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetClockInfo" {
                    @{
                        "ClockId"    = 12
                        "Brightness" = 100
                    } | Write-PodeJsonResponse; break
                }
                "Channel/SetIndex" {
                    if (0 -le $WebEvent.Data.SelectIndex -and $WebEvent.Data.SelectIndex -le 3) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/SetCustomPageIndex" {
                    if (0 -le $WebEvent.Data.CustomPageIndex -and $WebEvent.Data.CustomPageIndex -le 2) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/SetEqPosition" {
                    if (0 -le $WebEvent.Data.EqPosition) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/CloudIndex" {
                    if (0 -le $WebEvent.Data.Index -and $WebEvent.Data.Index -le 2) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetIndex" {
                    @{SelectIndex = 1 } | Write-PodeJsonResponse; break
                }
                "Channel/SetBrightness" {
                    if (0 -le $WebEvent.Data.Brightness -and $WebEvent.Data.Brightness -le 100) {
                        $WebEvent.Data | Out-PodeHost
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetAllConf" {
                    @{
                        "error_code"          = 0
                        "Brightness"          = 100
                        "RotationFlag"        = 1
                        "ClockTime"           = 60
                        "GalleryTime"         = 60
                        "SingleGalleyTime"    = 5
                        "PowerOnChannelId"    = 1
                        "GalleryShowTimeFlag" = 1
                        "CurClockId"          = 1
                        "Time24Flag"          = 1
                        "TemperatureMode"     = 1
                        "GyrateAngle"         = 1
                        "MirrorFlag"          = 1
                    } | Write-PodeJsonResponse; break
                }
                "Sys/LogAndLat" {
                    if (0 -le $WebEvent.Data.Longitude -and $WebEvent.Data.Longitude -le 180 -and 0 -le $WebEvent.Data.Latitude -and $WebEvent.Data.Latitude -le 90) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Sys/TimeZone" {
                    if ($WebEvent.Data.TimeZoneValue -match "GMT(\+|-)\d{0,2}") {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Device/SetUTC" {
                    if ($WebEvent.Data.Utc -gt 0) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/OnOffScreen" {
                    if (0 -le $WebEvent.Data.OnOff -and $WebEvent.Data.OnOff -le 1) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetTimer" {
                    if ($WebEvent.Data.Minute -ge 0 -and $WebEvent.Data.Second -ge 0 -and 0 -le $WebEvent.Data.Status -and $WebEvent.Data.Status -le 1) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetStopWatch" {
                    if (0 -le $WebEvent.Data.Status -and $WebEvent.Data.Status -le 2) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetScoreBoard" {
                    if (0 -le $WebEvent.Data.BlueScore -and $WebEvent.Data.BlueScore -le 999 -and 0 -le $WebEvent.Data.RedScore -and $WebEvent.Data.RedScore -le 999) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetNoiseStatus" {
                    if (0 -le $WebEvent.Data.NoiseStatus -and $WebEvent.Data.NoiseStatus -le 1) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Device/PlayTFGif" {
                    if ($WebEvent.Data.FileType -eq 2 -and $WebEvent.Data.FileName -match "(http)://[^\s/$.?#].[^\s]*") {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    } elseif ($WebEvent.Data.FileType -eq 1 -and $WebEvent.Data.FileName -match "^[^/^\\]+$") {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    } elseif ($WebEvent.Data.FileType -eq 0 -and $WebEvent.Data.FileName -match ".+\.gif") {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/GetHttpGifId" {
                    @{
                        "error_code" = 0
                        "PicId"      = 100
                    } | Write-PodeJsonResponse; break
                }
                "Draw/ResetHttpGifId" {
                    @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                }
                "Draw/SendHttpGif" {
                    if (
                        $WebEvent.Data.PicNum -lt 60 -and
                        (
                            $WebEvent.Data.PicWidth -eq 16 -or
                            $WebEvent.Data.PicWidth -eq 32 -or
                            $WebEvent.Data.PicWidth -eq 64
                        ) -and
                        (
                            $WebEvent.Data.PicOffset -gt 0 -and
                            $WebEvent.Data.PicOffset -lt $WebEvent.Data.PicNum
                        ) -and
                        $WebEvent.Data.PicID -gt 1 -and
                        $WebEvent.Data.PicSpeed -gt 1 -and
                        $WebEvent.Data.PicData -match "^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$"
                    ) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/SendHttpText" {
                    if (
                        $WebEvent.Data.TextId -lt 20 -and
                        $WebEvent.Data.x -gt 0 -and
                        $WebEvent.Data.y -gt 0 -and
                        0 -le $WebEvent.Data.dir -and $WebEvent.Data.dir -le 1 -and
                        0 -le $WebEvent.Data.font -and $WebEvent.Data.font -le 7 -and
                        16 -lt $WebEvent.Data.TestWidth -and $WebEvent.Data.TestWidth -lt 64 -and
                        $WebEvent.Data.TextString.Length -lt 512 -and
                        $WebEvent.Data.speed -gt 0 -and
                        $WebEvent.Data.color -match "#(?:[0-9a-fA-F] { 3 }) { 1,2}" -and
                        1 -le $WebEvent.Data.align -and $WebEvent.Data.align -le 3
                    ) {
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/ClearHttpText" {
                    @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                }
                "Draw/SendHttpItemList" {
                    if (
                        $WebEvent.Data.ItemList.Count -gt 0
                    ) {
                        $WebEvent.Data.ItemList | ForEach-Object {
                            if (
                                $_.TextId -lt 40 -and
                                1 -le $_.type -and $_.type -le 22 -and
                                $_.x -gt 0 -and
                                $_.y -gt 0 -and
                                0 -le $_.dir -and $_.dir -le 1 -and
                                0 -le $_.font -and $_.font -le 7 -and
                                $_.TestWidth -gt 0 -and
                                $_.Textheight -gt 0 -and
                                $_.TextString.Length -lt 512 -and
                                $_.speed -gt 0 -and
                                $_.color -match "#(?:[0-9a-fA-F] { 3 }) { 1,2}" -and
                                1 -le $_.align -and $_.align -le 3
                            ) {
                                # Do nothing, still need to check the rest of the array
                            } else {
                                @{error_code = 1 } | Write-PodeJsonResponse; break
                            }
                        }
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/CommandList" {
                    if (
                        $WebEvent.Data.CommandList.Count -gt 0
                    ) {
                        $WebEvent.Data.CommandList | ForEach-Object {
                            if ($_.Command -notlike "Draw/CommandList") {
                                $Result = Invoke-WebRequest -Uri "http://$($Address):$($Port)/post" -Body $_
                                if (($Result.error_code -and $Result.error_code -gt 0) -or $null -eq $Result.error_code) {
                                    # Do nothing, still need to check the rest of the array
                                } else {
                                    @{error_code = 1 } | Write-PodeJsonResponse; break
                                }
                            } else {
                                @{error_code = 1 } | Write-PodeJsonResponse; break
                            }
                        }
                        @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/UseHTTPCommandSource" {
                    if ($WebEvent.Data.CommandList.Count -match "(http)://[^\s/$.?#].[^\s]*") {
                        @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                    }
                }
                Default {
                    @{error_code = 1 } | Write-PodeJsonResponse
                }
            }
        } else {
            @{error_code = 1 } | Write-PodeJsonResponse
        }
        $WebEvent.Data | Out-Default
    } -ContentType "application/json"
    Add-PodeRoute -Method Get -Path '/get' -ScriptBlock {
        "Hello World divoom!" | Write-PodeTextResponse -ContentType "text/plain"
        "Hello World divoom!" | Out-Default
    }
}
