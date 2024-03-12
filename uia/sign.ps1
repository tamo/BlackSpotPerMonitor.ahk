Param([Parameter(Mandatory)][String]$target, [String]$dnsname = "BlackSpotPerMonitor.ahk")
Set-AuthenticodeSignature -FilePath $target -Certificate (Get-ChildItem Cert:\CurrentUser\My -DnsName $dnsname)
