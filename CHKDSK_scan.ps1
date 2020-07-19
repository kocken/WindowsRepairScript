$chkdskPrompt = Read-Host "Would you like to scan with CHKDSK? This will temporarily disable the actively scanned disk(s). The main disk can be scheduled for scanning next startup, and the other disks will start to get scanned now. Do you wish to run this scan? (Y/N)"
if ($chkdskPrompt -ne 'y') {
	break
}

Write-Output ""
$chkdskComprehensiveHddScanPrompt = Read-Host "Would you like to use the CHKDSK '/R' parameter to scan HDDs for bad sectors?`r`nThis is a more comprehensive scan option for HDDs, which takes longer time to run. It can take multiple hours on a slow HDD, while the regular scan (without the '/R' parameter) is fast and only takes a few minutes.`r`nThe SSD scans will ignore this parameter as it can cause the SSD to shrink in data size.`r`nDo you wish to use the '/R' parameter for the HDD scans? (Y/N)"

Get-PhysicalDisk | Where-Object MediaType | ForEach-Object {
	$physicalDisk = $_
	$driveLetter = $physicalDisk | Get-Disk | Get-Partition | Where-Object DriveLetter | Select -ExpandProperty DriveLetter
	if ($driveLetter) {
		if ($chkdskComprehensiveHddScanPrompt -eq 'y' -and $physicalDisk.MediaType -eq "HDD") {
			$message = "`r`n`r`n" + 'Starting "CHKDSK ' + $driveLetter + ': /F /R /X" scan' + "`r`n"
			Write-Output $message
			
			CHKDSK ${driveLetter}: /F /R /X
		}
		elseif ($physicalDisk.MediaType -eq "HDD" -or $physicalDisk.MediaType -eq "SSD") {
			$message = "`r`n`r`n" + 'Starting "CHKDSK ' + $driveLetter + ': /F /X" scan' + "`r`n"
			Write-Output $message
			
			CHKDSK ${driveLetter}: /F /X
		}
	}
}

Write-Output `n
CMD /c PAUSE