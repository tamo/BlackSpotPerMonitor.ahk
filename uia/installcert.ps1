Param([String]$cert = "$PSScriptRoot\code_signing.crt")
Import-Certificate -FilePath $cert -Cert Cert:\CurrentUser\Root

# Use mmc.exe to remove the certs because Remove-Item cannot uninstall root certs
#   Get-ChildItem Cert:\CurrentUser\Root -DnsName BlackSpotPerMonitor.ahk | Remove-Item
# will fail
