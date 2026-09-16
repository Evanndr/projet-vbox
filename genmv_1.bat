@echo off
set NOM=test
set RAM=4096
set DISQUE=65536

echo Creation de la machine %NOM% 
VBoxManage createvm --name "%NOM%" --ostype "Debian_64" --register

echo Configuration RAM et Reseau
VBoxManage modifyvm "%NOM%" --memory %RAM% --nic1 nat

echo.
echo La machine à ete créée 
echo Ouvrrez VirtualBox pour verifier que la machine et le disque existent.
echo Appuie sur une touche pour la supprimer
pause

echo Suppression de la machine
VBoxManage unregistervm "%NOM%" --delete
echo Terminé !
pause