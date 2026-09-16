@echo off
set NOM=test
set RAM=4096
set DISQUE=65536

echo Creation de la machine %NOM% 
VBoxManage createvm --name "%NOM%" --ostype "Debian_64" --register

echo Configuration RAM et Reseau
VBoxManage modifyvm "%NOM%" --memory %RAM% --nic1 nat

echo Creation du Disque Dur
VBoxManage createmedium disk --filename "%NOM%.vdi" --size %DISQUE%
VBoxManage storagectl "%NOM%" --name "ControleurSATA" --add sata --controller IntelAhci
VBoxManage storageattach "%NOM%" --storagectl "ControleurSATA" --port 0 --device 0 --type hdd --medium "%NOM%.vdi"

echo.
echo La machine à ete créée 
echo Ouvrrez VirtualBox pour verifier que la machine et le disque existent.
echo Appuie sur une touche pour la supprimer
pause

echo Suppression de la machine
VBoxManage unregistervm "%NOM%" --delete
echo Terminé !
pause