function Get-IP {
	[CmdletBinding()]
	Param (
	)

	Process {
		$ip = Get-NetIPAddress |
			where InterfaceAlias -eq Wi-Fi |
			where PrefixOrigin -eq Dhcp
		return $ip.IPAddress
	}
}

<#
.SYNOPSIS
#>
function IP-Changed {
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline=$True)]
		[String]$OldIP
	)

	Process {
		return $OldIP -ne (Get-IP)
	}
}

<#
.SYNOPSIS
Returns an ISO 8601 timestamp
#>
function Get-Timestamp {
	[CmdletBinding()]
	Param (
	)

	Process {
		return Get-Date -Format s
	}
}

<#
.SYNOPSIS
#>
function Log {
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline=$True)]
		[String[]]$Text
	)

	Process {
		$Text | %{
			"[$(Get-Timestamp)] $_"
		}
	}
}

function Log-IP {
	[CmdletBinding()]
	Param (
	)

	Process {
		return "[$(Get-Timestamp)] $(Get-IP)"
	}
}

<#
.SYNOPSIS
#>
function Reset-IP {
	[CmdletBinding()]
	Param (
	)

	Process {
		ipconfig /release  "*Wi-Fi"
		ipconfig /release6 "*Wi-Fi"
		ipconfig /renew    "*Wi-Fi"
		ipconfig /renew6   "*Wi-Fi"
	}
}
