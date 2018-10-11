[CmdletBinding()]
Param (
	[Parameter(ValueFromPipeline=$True)]
	[Int]$Interval = 60
)

. .\logging.ps1

$ip = Get-IP
$old_ip = $ip
Log-IP
while($True) {
	If(IP-Changed $ip) {
		$old_ip = $ip
		$ip = Get-IP
		Log-IP
		#Log "$old_ip $([Char]0x2192) $ip"
	}
	sleep $Interval
}
