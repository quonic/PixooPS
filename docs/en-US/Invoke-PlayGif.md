---
external help file: PixooPS-help.xml
Module Name: PixooPS
online version:
schema: 2.0.0
---

# Invoke-PlayGif

## SYNOPSIS

Sends a link to a gif, from an http site, to a Pixoo64 device.

## SYNTAX

```powershell
Invoke-PlayGif [[-DeviceIP] <String>] [-UrlGif] <String> [<CommonParameters>]
```

## DESCRIPTION

Sends a link to a gif, from an http site, to a Pixoo64 device.

## EXAMPLES

### EXAMPLE 1

```powershell
Invoke-PlayGif -Url "http://example.com/MyAnimation.gif"
```

## PARAMETERS

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

### -UrlGif

An http url that points to a gif

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
