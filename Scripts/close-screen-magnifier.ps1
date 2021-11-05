﻿<#
.SYNOPSIS
	Closes the Screen Magnifier
.DESCRIPTION
	This script closes the Windows Screen Magnifier application gracefully.
.EXAMPLE
	PS> ./close-screen-magnifier
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Screen Magnifier" "Magnify" "magnify.exe" 
exit 0 # success
