---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Set-CloudChannel

## SYNOPSIS

Sets the Cloud Channel of a Pixoo64 device

## SYNTAX

```
Set-CloudChannel [-Channel] <Int32> [[-DeviceIP] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Sets the Cloud Channel of a Pixoo64 device, similar to Set-Face.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-CloudChannel -EqPosition 0
```

## PARAMETERS

### -Channel

The Eq Position that you wish a Pixoo64 device to be set to, 0 or greater.
0: Recommended Gallery, 1: Favourite, 2: Subscribed Artists

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
