#Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}

#Install nodejs
#https://nodejs.org/dist/v16.14.0/node-v16.14.0-x64.msi
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\node-v16.14.0-x64.msi', '/quiet'
    if (Test-Path "C:\Program Files\nodejs\node.exe") {
        Write-Log "nodejs has been installed"
    }
    else {
        write-log "Error locating the nodejs executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing nodejs: $ErrorMessage"
}