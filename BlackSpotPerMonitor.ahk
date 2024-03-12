#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force

;@Ahk2Exe-SetName        BlackSpotPerMonitor.ahk
;@Ahk2Exe-SetVersion     0.1
;@Ahk2Exe-SetDescription BlackSpotPerMonitor.ahk - workaround for video playback lags when subtitles are enabled
; https://www.reddit.com/r/netflix/comments/gir9kj/tip_found_a_fix_for_subtitles_causing_video/

; needs UI Access for UWP apps
;@Ahk2Exe-UpdateManifest 0, , , 1
; the compiled file needs to be placed in a trusted path, e.g. "C:\Program Files"
; and needs signing with a trusted cert (see .\uia\installcert.ps1)

TraySetIcon("shell32.dll", -19)
Persistent()
windows := Array()
loop (MonitorGetCount()) {
  hwnd := Gui()
  hwnd.Opt("+AlwaysOnTop -Caption +ToolWindow")
  hwnd.BackColor := "000000"
  MonitorGet(A_Index, &x, &y)
  hwnd.Show(Format("x{} y{} w{} h{} NoActivate", x, y, w := 1, h := 1))
  windows.Push({ hwnd: hwnd, x: x, y: y, w: w, h: h })
}

; probably the above is enough
while (true) {
  Sleep(1000)
  for (o in windows) {
    WinMove(o.x, o.y, o.w, o.h, o.hwnd) ; in case it has been moved
    WinSetAlwaysOnTop(true, o.hwnd) ; in case it has been covered by another always-on-top window
  }
}
