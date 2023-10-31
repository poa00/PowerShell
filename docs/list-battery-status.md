*list-battery-status.ps1*
================

This PowerShell script lists the battery status.

Parameters
----------
```powershell
PS> ./list-battery-status.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-battery-status.ps1



PowerLineStatus      : Online
BatteryChargeStatus  : NoSystemBattery
...

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
	Lists the battery status
.DESCRIPTION
	This PowerShell script lists the battery status.
.EXAMPLE
	PS> ./list-battery-status.ps1

	PowerLineStatus      : Online
	BatteryChargeStatus  : NoSystemBattery
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Add-Type -Assembly System.Windows.Forms
	[System.Windows.Forms.SystemInformation]::PowerStatus
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of list-battery-status.ps1 as of 10/19/2023 08:11:38)*