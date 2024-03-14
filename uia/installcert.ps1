Param([String]$cert = "$PSScriptRoot\code_signing.crt")
Import-Certificate -FilePath $cert -Cert Cert:\CurrentUser\Root

# To remove the cert, run
#   certutil.exe -delstore -user Root BlackSpotPerMonitor.ahk
# because
#   Get-ChildItem Cert:\CurrentUser\Root -DnsName BlackSpotPerMonitor.ahk | Remove-Item
# will fail ("Remove-Item: The operation is on user root store and UI is not allowed.")
