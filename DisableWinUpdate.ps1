# WinUpdateToggle.ps1
# Script para activar o desactivar Windows Update y BITS con menú interactivo

Write-Host "=============================="
Write-Host "   Control de Windows Update  "
Write-Host "=============================="
Write-Host "1) Activar Windows Update"
Write-Host "2) Desactivar Windows Update"
Write-Host "=============================="

# Asegurar ejecución como Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}


$opcion = Read-Host "Elige una opción (1 o 2)"

switch ($opcion) {
    "1" {
        Write-Host "Activando Windows Update y BITS..."
        Set-Service wuauserv -StartupType Manual
        Start-Service wuauserv
        Set-Service bits -StartupType Manual
        Start-Service bits
        Write-Host "Windows Update y BITS están ACTIVADOS." -ForegroundColor Green
    }
    "2" {
        Write-Host "Desactivando Windows Update y BITS..."
        Stop-Service wuauserv -Force
        Set-Service wuauserv -StartupType Disabled
        Stop-Service bits -Force
        Set-Service bits -StartupType Disabled
        Write-Host "Windows Update y BITS están DESACTIVADOS." -ForegroundColor Red
    }
    default {
        Write-Host "Opción no válida. Intenta de nuevo." -ForegroundColor Yellow
    }
}

Write-Host "`nPresiona cualquier tecla para salir..."
[void][System.Console]::ReadKey($true)
