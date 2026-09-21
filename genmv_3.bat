@echo off

set RAM=4096
set DISQUE=65536
set FICHIER_TMP=%TEMP%\liste_vms_genmv.txt

if "%1"=="" goto Erreur
if "%1"=="L" goto Lister_les_VM
if "%1"=="N" goto Creer_une_VM
if "%1"=="S" goto Supprimer_une_VM
if "%1"=="D" goto Demarrer_une_VM
if "%1"=="A" goto Arreter_une_VM

echo ERREUR : commande "%1" inconnue. Attendu : L, N, S, D ou A.
:: "%1 correspond à l'option choisie dans le terminal. C'est ce qui est mis en paramètre"
exit /b 1


:Erreur
echo ERREUR : aucune commande fournie.
exit /b 1





:Lister_les_VM

VBoxManage list vms > "%FICHIER_TMP%"

for %%F in ("%FICHIER_TMP%") do if %%~zF==0 (
    echo Aucune machine enregistree dans VirtualBox.
    del "%FICHIER_TMP%"
    goto fin
)

echo Liste des machines enregistrees dans VirtualBox :
:: Cela lit le fichier ligne par ligne "tokens=1" indique à la boucle de lire une ligne du fichier et de ne garder ce nom est immédiatement stocké dans la variable %%v
for /f "tokens=1" %%v in (%FICHIER_TMP%) do call :Afficher_une_VM %%v

del "%FICHIER_TMP%"
goto fin





:Afficher_une_VM
:: %1 c'est le %%v de "Lister_les_VM"
set NOMVM=%~1
echo - %NOMVM%

for /f "tokens=1,* delims=:" %%a in ('VBoxManage getextradata "%NOMVM%" DateCreation') do (
    if "%%a"=="Value" (echo     Creee le : %%b) else (echo     Date de creation : non renseignee)
)
for /f "tokens=1,* delims=:" %%a in ('VBoxManage getextradata "%NOMVM%" Utilisateur') do (
    if "%%a"=="Value" (echo     Creee par : %%b) else (echo     Utilisateur : non renseigne)
)

goto :eof






:Creer_une_VM

if "%2"=="" goto Erreur_Nom_Manquant
set NOM=%2

echo Verification de l'existence de la machine %NOM%...
VBoxManage showvminfo "%NOM%" >nul 2>&1
if ERRORLEVEL 1 goto Creer_suite

echo La machine %NOM% existe deja : suppression avant recreation...
VBoxManage unregistervm "%NOM%" --delete
if ERRORLEVEL 1 goto Erreur_suppression_VM_existante



:Creer_suite

echo Creation de la machine %NOM%...
VBoxManage createvm --name "%NOM%" --ostype "Debian_64" --register
if ERRORLEVEL 1 goto Erreur_Creation

VBoxManage modifyvm "%NOM%" --memory %RAM% --nic1 nat
if ERRORLEVEL 1 goto Erreur_Configuration

VBoxManage createmedium disk --filename "%USERPROFILE%\VirtualBox VMs\%NOM%\%NOM%.vdi" --size %DISQUE%
if ERRORLEVEL 1 goto Erreur_disque
:: "%USERPROFILE%\VirtualBox VMs\%NOM%\%NOM%.vdi" est l'emplacement de la nouvelle VM

VBoxManage storagectl "%NOM%" --name "ControleurSATA" --add sata --controller IntelAhci
if ERRORLEVEL 1 goto Erreur_Controleur

VBoxManage storageattach "%NOM%" --storagectl "ControleurSATA" --port 0 --device 0 --type hdd --medium "%USERPROFILE%\VirtualBox VMs\%NOM%\%NOM%.vdi"
if ERRORLEVEL 1 goto Erreur_Attachement


:: Configuration du PXE (Ne marche pas)
:: VBoxManage modifyvm "%NOM%" --boot1 net --boot2 disk --boot3 none --boot4 none
:: if ERRORLEVEL 1 goto Erreur_PXE
:: Indique au serveur TFTP de VirtualBox quel fichier charger (Ne marche pas)
:: VBoxManage modifyvm "%NOM%" --nattftpfile1 "%USERPROFILE%\.VirtualBox\TFTP\pxelinux.0"
:: if ERRORLEVEL 1 goto Erreur_TFTP


echo Enregistrement des donnees supplementaires (date, utilisateur)...
:: Ajoute la date comme informations en plus
VBoxManage setextradata "%NOM%" "DateCreation" "%DATE%"
:: Ajoute l'utilisateur date comme informations en plus
VBoxManage setextradata "%NOM%" "Utilisateur" "%USERNAME%"

echo La machine %NOM% a ete creee avec succes.
goto fin






:Supprimer_une_VM

if "%2"=="" goto erreur_nom_manquant
set NOM=%2

VBoxManage unregistervm "%NOM%" --delete
if ERRORLEVEL 1 goto Erreur_Suppression

echo Machine %NOM% supprimee.
goto fin





:Demarrer_une_VM

if "%2"=="" goto Erreur_Nom_Manquant
set NOM=%2

VBoxManage startvm "%NOM%" --type headless
if ERRORLEVEL 1 goto Erreur_Demarrage

echo Machine %NOM% demarree.
goto fin





:Arreter_une_VM

if "%2"=="" goto erreur_nom_manquant
set NOM=%2

VBoxManage controlvm "%NOM%" poweroff
if ERRORLEVEL 1 goto Erreur_Arret

echo Machine %NOM% arretee.
goto fin







::  Messages d'érreur

:Erreur_Nom_Manquant
echo ERREUR : cette commande necessite un nom de machine en 2e argument.
exit /b 1

:Erreur_suppression_VM_existante
echo ERREUR : impossible de supprimer la machine existante %NOM%
exit /b 1

:Erreur_Creation
echo ERREUR : la creation de la VM %NOM% a echoue
exit /b 1

:Erreur_Configuration
echo ERREUR : la configuration de %NOM% a echoue
exit /b 1

:Erreur_Disque
echo ERREUR : la creation du disque pour %NOM% a echoue
exit /b 1

:Erreur_Controleur
echo ERREUR : la creation du controleur SATA pour %NOM% a echoue
exit /b 1

:Erreur_Attachement
echo ERREUR : l'attachement du disque pour %NOM% a echoue
exit /b 1

:Erreur_Suppression
echo ERREUR : impossible de supprimer la machine %NOM%. Verifiez qu'elle existe.
exit /b 1

:Erreur_Demarrage
echo ERREUR : impossible de demarrer la machine %NOM%. Verifiez qu'elle existe.
exit /b 1

:Erreur_Arret
echo ERREUR : impossible d'arreter la machine %NOM%. Verifiez qu'elle est demarree.
exit /b 1

:Erreur_PXE
echo ERREUR : La configuration du boot reseau PXE a echoue.
exit /b 1

:Erreur_TFTP
echo ERREUR : La configuration du TFTP a echoue.
exit /b 1

:fin
