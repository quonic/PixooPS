---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Set-Noise

## SYNOPSIS
Set the NoiseStatus on a Pixoo64 device

## SYNTAX

```
Set-Noise [-On] [-Off] [[-DeviceIP] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the NoiseStatus on a Pixoo64 device

## EXAMPLES

### EXAMPLE 1
```
Set-Noise -On
```

### EXAMPLE 2
```
Set-Noise -Off
```

## PARAMETERS

### -On
Set the NoiseStatus to 1, ie On

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Off
Set the NoiseStatus to 0, ie Off

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Position: 1
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
