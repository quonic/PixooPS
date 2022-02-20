---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version: https://go.microsoft.com/fwlink/?LinkID=2097049
schema: 2.0.0
---

# Set-PixooTimeZone

## SYNOPSIS

Sets the TimeZone of a Pixoo64 device

## SYNTAX

```
Set-PixooTimeZone [-TimeZone] <String> [[-DeviceIP] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Sets the TimeZone of a Pixoo64 device.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-PixooTimeZone -TimeZone "GMT-5"
```

## PARAMETERS

### -TimeZone

The TimeZone that you wish a Pixoo64 device to be set to.
Must be in the GMT format, like GMT-5/GMT+1

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
