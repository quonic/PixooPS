[CmdletBinding()]
param (
    [Parameter()]
    [int]
    $Port = 80,
    [Parameter()]
    [string]
    $Address = "0.0.0.0"
)

if ((Get-Module Pode -ListAvailable).Count -eq 0) {
    Install-Module Pode -Scope CurrentUser -Force
}
Import-Module Pode

Start-PodeServer {
    Add-PodeEndpoint -Address $Address -Port $Port -Protocol Http

    Add-PodeRoute -Method Post -Path '/post' -ScriptBlock {
        if ($WebEvent.Data.Command) {
            switch ($WebEvent.Data.Command) {
                "Channel/SetClockSelectId" {
                    if ($WebEvent.Data.ClockId -ge 0) {
                        "Channel/SetIndex: ClockId: $($WebEvent.Data.ClockId)" | Out-Default
                        "Channel/SetIndex: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetClockInfo" {
                    "Channel/GetClockInfo: ClockId: 12" | Out-Default
                    "Channel/GetClockInfo: Brightness: 100" | Out-Default
                    @{
                        "ClockId"    = 12
                        "Brightness" = 100
                    } | Write-PodeJsonResponse; break
                }
                "Channel/SetIndex" {
                    if (0 -le $WebEvent.Data.SelectIndex -and $WebEvent.Data.SelectIndex -le 3) {
                        "Channel/SetIndex: SelectIndex: $($WebEvent.Data.SelectIndex)" | Out-Default
                        "Channel/SetIndex: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/SetCustomPageIndex" {
                    if (0 -le $WebEvent.Data.CustomPageIndex -and $WebEvent.Data.CustomPageIndex -le 2) {
                        "Channel/SetCustomPageIndex: CustomPageIndex: $($WebEvent.Data.CustomPageIndex)" | Out-Default
                        "Channel/SetCustomPageIndex: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/SetEqPosition" {
                    if (0 -le $WebEvent.Data.EqPosition) {
                        "Channel/SetEqPosition: EqPosition: $($WebEvent.Data.EqPosition)" | Out-Default
                        "Channel/SetEqPosition: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/CloudIndex" {
                    if (0 -le $WebEvent.Data.Index -and $WebEvent.Data.Index -le 2) {
                        "Channel/CloudIndex: Index: $($WebEvent.Data.Index)" | Out-Default
                        "Channel/CloudIndex: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetIndex" {
                    "Channel/GetIndex: SelectIndex: 1" | Out-Default
                    @{SelectIndex = 1 } | Write-PodeJsonResponse; break
                }
                "Channel/SetBrightness" {
                    if (0 -le $WebEvent.Data.Brightness -and $WebEvent.Data.Brightness -le 100) {
                        "Channel/SetBrightness: Brightness: $($WebEvent.Data.Brightness)" | Out-Default
                        "Channel/SetBrightness: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/GetAllConf" {
                    "Channel/GetAllConf: error_code: 0" | Out-Default
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
                        "Sys/LogAndLat: Longitude: $($WebEvent.Data.Longitude)" | Out-Default
                        "Sys/LogAndLat: Latitude: $($WebEvent.Data.Latitude)" | Out-Default
                        "Sys/LogAndLat: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Sys/TimeZone" {
                    if ($WebEvent.Data.TimeZoneValue -match "GMT(\+|-)\d{0,2}") {
                        "Sys/TimeZone: TimeZoneValue: $($WebEvent.Data.TimeZoneValue)" | Out-Default
                        "Sys/TimeZone: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Device/SetUTC" {
                    if ($WebEvent.Data.Utc -gt 0) {
                        "Device/SetUTC: Utc: $($WebEvent.Data.Utc)" | Out-Default
                        "Device/SetUTC: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Channel/OnOffScreen" {
                    if (0 -le $WebEvent.Data.OnOff -and $WebEvent.Data.OnOff -le 1) {
                        "Channel/OnOffScreen: OnOff: $($WebEvent.Data.OnOff)" | Out-Default
                        "Channel/OnOffScreen: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetTimer" {
                    if ($WebEvent.Data.Minute -ge 0 -and $WebEvent.Data.Second -ge 0 -and 0 -le $WebEvent.Data.Status -and $WebEvent.Data.Status -le 1) {
                        "Tools/SetTimer: Minute: $($WebEvent.Data.Minute)" | Out-Default
                        "Tools/SetTimer: Second: $($WebEvent.Data.Second)" | Out-Default
                        "Tools/SetTimer: Status: $($WebEvent.Data.Status)" | Out-Default
                        "Tools/SetTimer: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetStopWatch" {
                    if (0 -le $WebEvent.Data.Status -and $WebEvent.Data.Status -le 2) {
                        "Tools/SetStopWatch: Status: 2" | Out-Default
                        "Tools/SetStopWatch: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetScoreBoard" {
                    if (0 -le $WebEvent.Data.BlueScore -and $WebEvent.Data.BlueScore -le 999 -and 0 -le $WebEvent.Data.RedScore -and $WebEvent.Data.RedScore -le 999) {
                        "Tools/SetScoreBoard: BlueScore: $($WebEvent.Data.BlueScore)" | Out-Default
                        "Tools/SetScoreBoard: RedScore: $($WebEvent.Data.RedScore)" | Out-Default
                        "Tools/SetScoreBoard: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Tools/SetNoiseStatus" {
                    if (0 -le $WebEvent.Data.NoiseStatus -and $WebEvent.Data.NoiseStatus -le 1) {
                        "Tools/SetNoiseStatus: NoiseStatus: 1" | Out-Default
                        "Tools/SetNoiseStatus: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Device/PlayTFGif" {
                    if ($WebEvent.Data.FileType -eq 2 -and $WebEvent.Data.FileName -match "(http):\/\/[^\s\/$.?#].[^\s]*") {
                        "Device/PlayTFGif: FileType: $($WebEvent.Data.FileType)" | Out-Default
                        "Device/PlayTFGif: FileName: $($WebEvent.Data.FileName)" | Out-Default
                        "Device/PlayTFGif: Matched" | Out-Default
                        "Device/PlayTFGif: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    } elseif ($WebEvent.Data.FileType -eq 1 -and $WebEvent.Data.FileName -match "^[^/^\\]+$") {
                        "Device/PlayTFGif: FileType: $($WebEvent.Data.FileType)" | Out-Default
                        "Device/PlayTFGif: FileName: $($WebEvent.Data.FileName)" | Out-Default
                        "Device/PlayTFGif: Matched" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    } elseif ($WebEvent.Data.FileType -eq 0 -and $WebEvent.Data.FileName -match ".+\.gif") {
                        "Device/PlayTFGif: FileType: $($WebEvent.Data.FileType)" | Out-Default
                        "Device/PlayTFGif: FileName: $($WebEvent.Data.FileName)" | Out-Default
                        "Device/PlayTFGif: Matched" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    } else {
                        "Device/PlayTFGif: FileType: $($WebEvent.Data.FileType)" | Out-Default
                        "Device/PlayTFGif: FileName: $($WebEvent.Data.FileName)" | Out-Default
                        @{error_code = 1 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/GetHttpGifId" {
                    "Draw/GetHttpGifId: error_code: 0" | Out-Default
                    @{
                        "error_code" = 0
                        "PicId"      = 100
                    } | Write-PodeJsonResponse; break
                }
                "Draw/ResetHttpGifId" {
                    "Draw/ResetHttpGifId: error_code: 0" | Out-Default
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
                        "Draw/SendHttpGif: error_code: 0" | Out-Default
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
                        "Draw/SendHttpText: error_code: 0" | Out-Default
                        @{error_code = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/ClearHttpText" {
                    "Draw/ClearHttpText: error_code: 0" | Out-Default
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
                        "Draw/SendHttpItemList: error_code: 0" | Out-Default
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
                                # No recursion
                                @{error_code = 1 } | Write-PodeJsonResponse; break
                            }
                        }
                        "Draw/CommandList: error_code: 0" | Out-Default
                        @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                    }
                }
                "Draw/UseHTTPCommandSource" {
                    if ($WebEvent.Data.CommandList.Count -match "(http)://[^\s/$.?#].[^\s]*") {
                        "Draw/UseHTTPCommandSource: Matched" | Out-Default
                        "Draw/UseHTTPCommandSource: error_code: 0" | Out-Default
                        @{ "error_code" = 0 } | Write-PodeJsonResponse; break
                    }
                }
                Default {
                    "Data: error_code: 1" | Out-Default
                    @{error_code = 1 } | Write-PodeJsonResponse
                }
            }
        } else {
            "NoData: error_code: 1" | Out-Default
            $WebEvent | Out-Default
            @{error_code = 1 } | Write-PodeJsonResponse
        }
    } -ContentType "application/json"
    Add-PodeRoute -Method Get -Path '/get' -ScriptBlock {
        "Hello World divoom!" | Write-PodeTextResponse -ContentType "text/plain"
        "Hello World divoom!" | Out-Default
    }
} -Verbose
