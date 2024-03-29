Param([Int]$years = 20, [String]$cert = "$PSScriptRoot\code_signing.crt", [String]$dnsname = "BlackSpotPerMonitor.ahk")
New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName $dnsname -Type CodeSigning -NotAfter (Get-Date).AddYears($years)
Export-Certificate      -Cert (Get-ChildItem Cert:\CurrentUser\My -DnsName $dnsname) -FilePath $cert

# To uninstall the cert and the key, run
#   Remove-Item         -Path (Get-ChildItem Cert:\CurrentUser\My -DnsName BlackSpotPerMonitor.ahk).PSPath -DeleteKey
#
# Some key files will be kept if you forget to use -DeleteKey
# https://www.pkisolutions.com/deleting-certificates-from-windows-certificate-store-programmatically-powershell-and-c/
