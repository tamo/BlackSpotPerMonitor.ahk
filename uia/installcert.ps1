Param([String]$cert = "$PSScriptRoot\code_signing.crt")
Import-Certificate -FilePath $cert -Cert Cert:\CurrentUser\TrustedPublisher
Import-Certificate -FilePath $cert -Cert Cert:\CurrentUser\Root

# Use mmc.exe to remove the certs because Remove-Item cannot uninstall root certs
# because
#   Get-ChildItem Cert:\CurrentUser\Root             -DnsName BlackSpotPerMonitor.ahk | Remove-Item
# will fail
# though
#   Get-ChildItem Cert:\CurrentUser\TrustedPublisher -DnsName BlackSpotPerMonitor.ahk | Remove-Item
# and
#   Get-ChildItem Cert:\CurrentUser\CA               -DnsName BlackSpotPerMonitor.ahk | Remove-Item
# will succeed
