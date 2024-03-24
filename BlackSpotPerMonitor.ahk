#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force

;@Ahk2Exe-SetName        BlackSpotPerMonitor.ahk
;@Ahk2Exe-SetVersion     0.3
;@Ahk2Exe-SetDescription BlackSpotPerMonitor.ahk - workaround for video playback lags when subtitles are enabled
; https://www.reddit.com/r/netflix/comments/gir9kj/tip_found_a_fix_for_subtitles_causing_video/

; needs UI Access for UWP apps
;@Ahk2Exe-UpdateManifest 0, , , 1
; the compiled file needs to be placed in a trusted path, e.g. "C:\Program Files"
; and needs signing with a trusted cert (see .\uia\installcert.ps1)

TraySetIcon("shell32.dll", -19)
subscribe()
observe() ; probably unnecessary
return

subscribe() {
  global mons := Array()

  loop (MonitorGetCount()) {
    gobj := Gui()
    gobj.Opt("+AlwaysOnTop -Caption +ToolWindow")
    gobj.BackColor := "0x000000"
    MonitorGet(A_Index, &x, &y)
    gobj.Show(Format("x{} y{} w{} h{} NoActivate", x, y, w := 1, h := 1))

    item := Format("{}: {}, {}", A_Index, x, y)
    mons.Push({ gui: gobj, x: x, y: y, w: w, h: h, menu: item, enabled: true })
    A_TrayMenu.Insert(String(A_Index) . "&", item, toggle) ; the same number
    A_TrayMenu.Check(item)
  }
  A_TrayMenu.Add()
}

observe() {
  CoordMode("Pixel", "Screen")
  while (true) {
    Sleep(1000)
    for (o in mons) {
      if (!o.enabled) {
        continue
      }
      WinMove(o.x, o.y, o.w, o.h, o.gui.Hwnd) ; in case it has been moved
      WinSetAlwaysOnTop(true, o.gui.Hwnd) ; in case it has been covered by another always-on-top window
      if (PixelGetColor(o.x, o.y) != ("0x" . o.gui.BackColor)) {
        TraySetIcon("shell32.dll", -11)
        A_IconTip := "BlackSpotPerMonitor.ahk`nis not working`n(maybe it failed to get UIAccess)"
      }
    }
  }
}

toggle(name, pos, traymenu) {
  o := mons[pos]
  if (o.enabled := !o.enabled) {
    traymenu.Check(name)
    o.gui.Show()
  } else {
    traymenu.Uncheck(name)
    o.gui.Hide()
  }
}
