#  Copyright (c) chenmosu@cn.ibm.com.  All rights reserved.
# Author: Chen Mo ³ÂÄ¬
# Personal profile script for all environments
# Version: 1.0.1.0
# 2020-01-08 Created
# 2020-03-08 Update:
# - Checks for environments and listing all environment variables




# Scanning for 

# Populating Environment Variables:
# vim console text editor
$env:Path += ";C:\Program Files (x86)\Vim\vim81"    
#Add .NET dir to Path
$env:Path += ";C:\windows\Microsoft.Net\Framework64\V4.0.30319\"
$env:Path += ";C:\Program Files\PostgreSQL\10\bin\"
#Add CMAM XML Reader to Path
$env:Path += ";C:\Users\MoChen\source\repos\CMAM_xml_sql\CMAM_xml_sql\bin\Debug\"

# Set Aliases
Set-Alias -Name vs -Value "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
Set-Alias -Name vi -Value "C:\Program Files (x86)\Vim\vim81\vim.exe"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


# Profile Script Start: Scanning for dead $env:Path values
$DeadEnvVarCounter = 0
foreach($path in $env:Path -split ";")
{
    if(-not (Test-Path $path))
    { 
        Write-Warning "$path is not found";
        $DeadEnvVarCounter++
    }
}
Write-Host "There are $DeadEnvVarCounter dead environment variable(s) found, please fix";

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
