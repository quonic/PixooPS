# PixooPS

[![CI](https://github.com/quonic/PixooPS/actions/workflows/CI.yaml/badge.svg?branch=main)](https://github.com/quonic/PixooPS/actions/workflows/CI.yaml)

PixooPS is a module to control Divoom Pixoo64 devices.

## Overview

You can change the current face, turn on and off the screen, display an animated gif and such.

## Requirements

- Any OS that PowerShell can be installed on.
- PowerShell 5.1 and PowerShell 7 are supported, though PowerShell 7 or greater is recommended.

## Installation

Install the module under your user's scope.

```powershell
Install-Module PixooPS -Scope CurrentUser
```

## Examples

```powershell
$Face = Get-FaceList | Where-Object { $_.Name -like "Big Time" }
$IP = Find-Pixoo
Set-Channel -Channel Faces -DeviceIP $IP
Start-Sleep -Seconds 1
Set-Face -FaceId $Face.ClockId -DeviceIP $IP
```

## Documentation

[![pages-build-deployment](https://github.com/quonic/PixooPS/actions/workflows/pages/pages-build-deployment/badge.svg?branch=pages)](https://github.com/quonic/PixooPS/actions/workflows/pages/pages-build-deployment)

[GitHub Pages](https://quonic.github.io/PixooPS/)
