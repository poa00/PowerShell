*install-basic-apps.ps1*
================

This PowerShell script installs basic Windows apps such as browser, e-mail client, etc.
NOTE: Apps from Microsoft Store are preferred (due to security and automatic updates).

Parameters
----------
```powershell
PS> ./install-basic-apps.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./install-basic-apps.ps1
⏳ (1/37) Loading Data/basic-apps.csv...            35 apps
⏳ (2/37) These apps will be installed or upgraded: 7-Zip · Aquile Reader ...

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Installs basic apps
.DESCRIPTION
	This PowerShell script installs basic Windows apps such as browser, e-mail client, etc.
	NOTE: Apps from Microsoft Store are preferred (due to security and automatic updates). 
.EXAMPLE
	PS> ./install-basic-apps.ps1
	⏳ (1/37) Loading Data/basic-apps.csv...            35 apps
	⏳ (2/37) These apps will be installed or upgraded: 7-Zip · Aquile Reader ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/37) Loading Data/basic-apps.csv...            " -noNewline
	$Table = Import-CSV "$PSScriptRoot/../Data/basic-apps.csv"
	$NumEntries = $Table.count
	"$NumEntries apps"
	Write-Host "⏳ (2/37) These apps will be installed or upgraded: " -noNewline
	foreach($Row in $Table) {
		[string]$AppName = $Row.APPLICATION
		Write-Host "$AppName · " -noNewline
	}
	""
	""
	"Installation will start in 15 seconds... (otherwise press <Control> <C> to abort)"
	Start-Sleep -seconds 15

	[int]$Step = 3
	[int]$Skipped = 0
	foreach($Row in $Table) {
		[string]$AppName = $Row.APPLICATION
		[string]$Category = $Row.CATEGORY
		[string]$AppID = $Row.APPID
		Write-Host " "
		Write-Host "⏳ ($Step/$($NumEntries + 2)) Installing $Category '$AppName'..."
		& winget install --id $AppID --accept-package-agreements --accept-source-agreements
        	if ($lastExitCode -ne "0") { $Skipped++ }
		$Step++
	}
	[int]$Installed = ($NumEntries - $Skipped)
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Installation of $Installed basic apps ($Skipped skipped) took $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of install-basic-apps.ps1 as of 10/19/2023 08:11:38)*