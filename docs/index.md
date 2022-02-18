# PixooPS

PixooPS is a module to control Divoom Pixoo64 devices.

## Overview

You can change the current face, turn on and off the screen, display an animated gif and such.

## Requirements

- Any OS that PowerShell can be installed on.
- PowerShell 5.1 and PowerShell 7 are supported, though PowerShell 7 or greater is reccomended.

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
