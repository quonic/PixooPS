---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Set-Face

## SYNOPSIS
Sets the face of a Pixoo64 device

## SYNTAX

```
Set-Face [-FaceId] <Int32> [[-DeviceIP] <String>] [<CommonParameters>]
```

## DESCRIPTION
Sets the face of a Pixoo64 device

## EXAMPLES

### EXAMPLE 1
```
$Face = Get-FaceList | Where-Object { $_.Name -like "Big Time" }
Set-Face -FaceId $Face.ClockId -DeviceIP (Find-Pixoo | Select-Object -First 1)
```

## PARAMETERS

### -FaceId
The face id that you wish a Pixoo64 device to be set to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceIP
The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
