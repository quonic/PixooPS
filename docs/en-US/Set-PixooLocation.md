---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Set-PixooLocation

## SYNOPSIS

Sets the Latitude and Longitude Location of a Pixoo64 device for it to get weather information

## SYNTAX

```powershell
Set-PixooLocation [-Latitude] <Single> [-Longitude] <Single> [[-DeviceIP] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Sets the Latitude and Longitude Location of a Pixoo64 device for it to get weather information

## EXAMPLES

### EXAMPLE 1

```powershell
Set-PixooLocation -Latitude 0 -Longitude 0
```

## PARAMETERS

### -Latitude

The Latitude of a Pixoo64 device

```yaml
Type: Single
Parameter Sets: (All)
Aliases: lat, lt

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Longitude

The Longitude of a Pixoo64 device

```yaml
Type: Single
Parameter Sets: (All)
Aliases: long, lng, lon, ln

Required: True
Position: 2
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES

General notes

## RELATED LINKS
