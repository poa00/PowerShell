﻿<#
.SYNOPSIS
	Lists DNS servers
.DESCRIPTION
	This PowerShell script measures the latency of public and free DNS servers and lists it.
.EXAMPLE
	PS> ./list-dns-servers
      
      Provider                IPv4                             Latency
      --------                ----                             -------
      AdGuard DNS             94.140.14.14 / 94.140.15.15      222 / 205 ms
      ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckDNSServer { param($Provider, $IPv4Pri, $IPv4Sec)
	$SW = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Pri 2>$null)
	[int]$Elapsed1 = $SW.Elapsed.TotalMilliseconds

	$SW = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Sec 2>$null)
	[int]$Elapsed2 = $SW.Elapsed.TotalMilliseconds

	New-Object PSObject -Property @{ Provider=$Provider; IPv4="$IPv4Pri / $IPv4Sec"; Latency="$Elapsed1 / $Elapsed2 ms" }
}

function List-DNS-Servers {
	Write-Progress "Loading Data/public-dns-servers.csv..."
      $Table = Import-CSV "$PSScriptRoot/../Data/public-dns-servers.csv"
	Write-Progress "Measuring latency..."
	foreach($Row in $Table) {
		CheckDNSServer $Row.PROVIDER $Row.IPv4_PRI $Row.IPv4_SEC	
	}
	Write-Progress -completed " "
}
 
try {
	List-DNS-Servers | Format-Table -property @{e='Provider';width=50},@{e='IPv4';width=32},@{e='Latency';width=15}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}