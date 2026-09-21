@echo off
chcp 65001 >nul
echo   Suppression du dossier courant du PATH 

:: Récupère le chemin absolu du dossier où se trouve ce .bat
set "DOSSIER_COURANT=%~dp0"
:: Retire le dernier antislash pour un format propre
set "DOSSIER_COURANT=%DOSSIER_COURANT:~0,-1%"

echo Dossier a retirer : %DOSSIER_COURANT%

:: Utilisation de PowerShell pour nettoyer le PATH utilisateur
powershell -Command "$pathUser = [Environment]::GetEnvironmentVariable('Path', 'User'); $paths = $pathUser -split ';' | Where-Object { $_ -ne '%DOSSIER_COURANT%' -and $_ -ne '' }; $newPath = $paths -join ';'; [Environment]::SetEnvironmentVariable('Path', $newPath, 'User'); Write-Host 'Suppression effectuee avec succes !' -ForegroundColor Green"
