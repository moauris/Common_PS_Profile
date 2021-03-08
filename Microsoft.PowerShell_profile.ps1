#  Copyright (c) chenmosu@cn.ibm.com.  All rights reserved.
# Personal profile script.
# Version: 1.0.0.1
# 2020-01-08 Edited

# Populating Environment Variables:
# vim console text editor
$env:Path += ";C:\Program Files (x86)\Vim\vim81"    
#Add .NET dir to Path
$env:Path += ";C:\windows\Microsoft.Net\Framework64\V4.0.30319\"
$env:Path += ";C:\Program Files\PostgreSQL\10\bin\"
#Add CMAM XML Reader to Path
$env:Path += ";C:\Users\MoChen\source\repos\CMAM_xml_sql\CMAM_xml_sql\bin\Debug\"

# Set Aliases
Set-Alias -Name vs -Value "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
Set-Alias -Name vi -Value "C:\Program Files (x86)\Vim\vim81\vim.exe"

# Define Functions
function help
{
    get-help $args[0] | out-host -paging
}

function man
{
    get-help $args[0] | out-host -paging
}

function mkdir
{
    new-item -type directory -path $args
}

function md
{
    new-item -type directory -path $args
}

Set-Alias -Name vs -Value "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
Set-Alias -Name vi -Value "C:\Program Files (x86)\Vim\vim81\vim.exe"

<# PSQL set user and password function
Write-Host "Loading Function Set-Pgvar."
$ts = Get-Date -Uformat "%s"
function Set-Pgvar {
# Setting PostgreSQL Variables to allow login-free
    $pguser = (Read-Host -Prompt "Enter psql User")
    $pgpass = (Read-Host -Prompt "Password" -AsSecureString)
    
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pgpass)
    $pgpass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    $env:PGUSER = $pguser
    $env:PGPASSWORD = $pgpass 
    
    psql -c '\g'
    if ($? -eq $False) {
        $env:PGUSER = ""
        $env:PGPASSWORD = ""
        Write-Warning "PostgreSQL Authentication Failed!"
        Write-Warning "User and pass information cleared!"
    }
    Else {
        Write-Host "Authenticated! Welcome, $pguser" -ForegroundColor Green
    }
}
$te = Get-Date -UFormat "%s"
Write-Host "Function Set-Pgvar Loaded. $([math]::round($te - $ts,4)) Seconds."
#>

<# Obsolete Prompt Function
function prompt {
    #"PS " + $(get-location) + "> "
    $LocData=$(get-location)
    $Host.UI.RawUI.WindowTitle="Windows Powershell | " + $LocData
    $str3=$(Get-History | Select -Last 1 | Select -Property "Id")
    if ($str3.Id -eq $Null) {$str3=0} else {$str3=$str3.Id}
    $promptstr="[$(hostname):$($env:UserName)]"
    $promptnum="[$str3] %"
    Write-Host ($promptstr + $promptnum) -NoNewline -ForegroundColor Yellow
    return " "
}

& {
    for ($i = 0; $i -lt 26; $i++) 
    { 
        $funcname = ([System.Char]($i+65)) + ':'
        $str = "function global:$funcname { set-location $funcname } " 
        invoke-expression $str 
    }
}
#>
function prompt {
    if(
    ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")
    ){
        $idchar = "$"
    }
    else{
        $idchar = "%"
    }
    
    #"PS " + $(get-location) + "> "
    $LocData=$(get-location)
    $Host.UI.RawUI.WindowTitle="Windows Powershell | " + $LocData
    $str3=$(Get-History | Select -Last 1 | Select -Property "Id")
    if ($str3.Id -eq $Null) {$str3=0} else {$str3=$str3.Id}
    $promptnum="$str3"
    Write-Host "[" -NoNewLine -ForegroundColor Gray
    Write-Host $(hostname) -NoNewline -ForegroundColor Yellow
    Write-Host ":" -NoNewLine -ForegroundColor Gray
    Write-Host $env:UserName -NoNewline -ForegroundColor Red
    Write-Host "][" -NoNewLine -ForegroundColor Gray
    Write-Host $promptnum -NoNewline -ForegroundColor Green
    Write-Host "] $idchar" -NoNewline -ForegroundColor Gray
    return " "
}







# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
