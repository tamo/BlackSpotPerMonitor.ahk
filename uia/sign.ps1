Param([Parameter(Mandatory)][String]$target, [String]$dnsname = "BlackSpotPerMonitor.ahk")
Set-AuthenticodeSignature -FilePath $target -Certificate (Get-ChildItem Cert:\CurrentUser\My -DnsName $dnsname)

# To delete the sign, see https://stackoverflow.com/questions/341168/can-i-remove-a-digital-signature-from-a-dll
