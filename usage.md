# Rapport SAÉ 51 - Projet VBox
**Auteur :** NODARI Evan
**Date :** 16 Septembre 2026

## Résumé
Ce document présente ma solution d'automatisation pour la création de machines virtuelles sous VirtualBox via des scripts Batch Windows. Il détaille le fonctionnement des scripts (`genmv_X.bat`), les limites actuelles, ainsi que les différents obstacles techniques rencontrés et la façon dont je les ais contournés.

## Utilisation
Le script genmv_3.bat s'exécute de manière non interactive depuis l'invite de commande (CLI). Il prend en charge des arguments pour exécuter des actions ciblées sur une machine spécifique.   
Syntaxe : genmv_3.bat [OPTION] [NOM_VM]

Les options disponibles sont les suivantes :   
- L (Lister) : Affiche la liste de toutes les machines enregistrées dans VirtualBox, ainsi que leurs métadonnées personnalisées (Date de création et Utilisateur). Cette option ne nécessite pas de second argument.   
- N (New/Créer) : Vérifie si la machine existe (et la supprime proprement si c'est le cas), puis crée une nouvelle VM avec la configuration suivante : OS Debian 64 bits, 4096 Mo de RAM, disque de 64 GiB en SATA, et réseau NAT.   
- S (Supprimer) : Désenregistre et supprime totalement la machine virtuelle spécifiée.   
- D (Démarrer) : Lance la machine virtuelle en arrière-plan (mode headless sans interface graphique).   
- A (Arrêter) : Force l'arrêt électrique (poweroff) de la machine virtuelle

### Intégration au PATH
Pour s'affranchir de la nécessité de se positionner dans le répertoire du projet pour lancer les commandes, deux scripts utilitaires ont été conçus :
- installer_path.bat : Récupère dynamiquement le chemin absolu du dossier courant via la variable `%~dp0` et l'ajoute de manière sécurisée aux variables d'environnement utilisateur de Windows (PATH) en s'appuyant sur l'API .NET de PowerShell.
- retirer_path.bat : Permet de nettoyer proprement le PATH en extrayant et supprimant uniquement le chemin du projet, garantissant ainsi une désinstallation propre de l'outil.

## Limites actuelles
- La configuration du PXE et le serveur TFTP interne de VirtualBox rencontrent actuellement des dysfonctionnements.

## Astuces techniques utilisées
- Gestion des variables : Utilisation de variables d'environnement en en-tête de script (set RAM=4096, set DISQUE=65536) pour rendre la configuration matérielle facilement modifiable..
- Stockage : Le chemin de création et d'attachement du disque dur virtuel (.vdi) a été forcé de manière absolue vers %USERPROFILE%\VirtualBox VMs\%NOM%\ pour éviter que les disques ne s'éparpillent dans le dossier d'exécution du script.
- Gestion des métadonnées : Le script injecte automatiquement la date de création (%DATE%) et le nom de l'utilisateur Windows (%USERNAME%) directement dans le fichier de configuration de la VM via la commande setextradata. Ces données sont ensuite récupérées via getextradata lors de l'appel de l'option L.
