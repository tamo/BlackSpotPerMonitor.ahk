# BlackSpotPerMonitor.ahk

## What is it

This tiny script just paints one black dot at (0, 0) on every monitor.


## Why

UWP video players suffer from a bug and play videos with lags when subtitle is enabled.

It seems that [the bug is in TimedTextSource handling of MediaPlayerElement](https://learn.microsoft.com/en-us/answers/questions/1360351/closed-captions-of-mediaplayerelement-causes-video).

Search for ["windows subtitles OR closedcaptions stutter OR lags"](https://www.google.com/search?q=windows+subtitles+OR+closedcaptions+stutter+OR+lags) and you will find that it has been around for years.

Someone [found a fix](https://www.reddit.com/r/netflix/comments/gir9kj/tip_found_a_fix_for_subtitles_causing_video/):

> have a single pixel of the corner of the magnifier visible

on the playback.

> The key here is the “always on top” property of magnifier. You can actually use any window that has this feature, such as task manager with always on top turned on

But doing it on maximized windows is hard. So BlackSpotPerMonitor.ahk helps.


## How

Normal apps cannot appear on top of UWP always-on-top apps even if invoked with admin privs. Only apps with uiAccess can.

[AutoHotkey has the ability](https://www.autohotkey.com/docs/v2/Program.htm#Installer_uiAccess) to run scripts with uiAccess, such as [right-click](https://www.autohotkey.com/docs/v2/FAQ.htm#uac).

If you prefer compiled exe files, you need
- to sign the files or get already-signed files
  - to trust the cert used to sign them if you haven't trusted it
- and to install the files in a trusted location, e.g. `Program Files`

The distributed exe files are signed with a cert which you can trust as root with uia.zip.

When you [cannot run .ps1 files](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_execution_policies), you can run an equivalent command on powershell prompt:
```
Import-Certificate -FilePath code_signing.crt -Cert Cert:\CurrentUser\Root
```

Of course you shouldn't trust any cert downloaded from the internet. That is a severe security risk.
