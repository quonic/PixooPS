# PixooPS

## about_PixooPS

PixooPS is a module to control Divoom Pixoo64 devices.
<!-- ```
ABOUT TOPIC NOTE:
The first header of the about topic should be the topic name.
The second header contains the lookup name used by the help system.

IE:
# Some Help Topic Name
## SomeHelpTopicFileName

This will be transformed into the text file
as `about_SomeHelpTopicFileName`.
Do not include file extensions.
The second header should have no spaces.
``` -->

## SHORT DESCRIPTION

PixooPS is a module to control Divoom Pixoo64 devices. Change the current face, turn on and off the screen, and such.

<!-- ```
ABOUT TOPIC NOTE:
About topics can be no longer than 80 characters wide when rendered to text.
Any topics greater than 80 characters will be automatically wrapped.
The generated about topic will be encoded UTF-8.
``` -->

## LONG DESCRIPTION

PixooPS is a module to control Divoom Pixoo64 devices. Change the current face, turn on and off the screen, and such. You can also have a Pixoo64 play a gif animation from a URL(http only).

<!-- ## Optional Subtopics

{{ Optional Subtopic Placeholder }} -->

## EXAMPLES

```powershell
$Face = Get-FaceList | Where-Object { $_.Name -like "Big Time" }
$IP = Find-Pixoo
Set-Channel -Channel Faces -DeviceIP $IP
Set-Face -FaceId $Face.ClockId -DeviceIP $IP
```

## NOTE

Sometime calling any REST method will cause the device to reboot for some reason. In that case the device changes it face to a default face on boot.

<!-- # TROUBLESHOOTING NOTE

{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }} -->

## SEE ALSO

Divoom's API documentation: <http://doc.divoom-gz.com/web/#/12?page_id=143>

## KEYWORDS

- Pixoo64
- Pixoo
- Divoom
