---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Set-Screen

## SYNOPSIS
Turns off and on the screen of a Pixoo64 device

## SYNTAX

### On
```
Set-Screen [-DeviceIP <String>] [-On] [<CommonParameters>]
```

### Off
```
Set-Screen [-DeviceIP <String>] [-Off] [<CommonParameters>]
```

## DESCRIPTION
Turns off and on the screen of a Pixoo64 device

## EXAMPLES

### EXAMPLE 1
```
Set-Screen -On
```

### EXAMPLE 2
```
Set-Screen -Off
```

## PARAMETERS

### -DeviceIP
The device's IP address, not needed if a Pixoo64 device is already in your ARP cache

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -On
Used to turn on the screen

```yaml
Type: SwitchParameter
Parameter Sets: On
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Off
Used to turn off the screen

```yaml
Type: SwitchParameter
Parameter Sets: Off
Aliases:

Required: True
Position: Named
Default value: False
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
