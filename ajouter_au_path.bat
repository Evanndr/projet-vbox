@echo off
chcp 65001 >nul
echo   Ajout du dossier courant au PATH utilisateur Windows

:: Récupère le chemin absolu du dossier où se trouve ce .bat
set "DOSSIER_COURANT=%~dp0"
:: Retire le dernier antislash pour un format propre
set "DOSSIER_COURANT=%DOSSIER_COURANT:~0,-1%"

echo Dossier a ajouter : %DOSSIER_COURANT%

:: Utilisation de PowerShell pour ajouter le dossier au PATH utilisateur
powershell -Command "$pathUser = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($pathUser -notlike '*%DOSSIER_COURANT%*') { [Environment]::SetEnvironmentVariable('Path', $pathUser + ';%DOSSIER_COURANT%', 'User'); Write-Host 'Ajout effectue avec succes !' -ForegroundColor Green } else { Write-Host 'Le dossier est deja dans le PATH.' -ForegroundColor Yellow }"
