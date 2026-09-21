# Journal de bord

* projet-vbox
* NODARI Evan
* Début du projet : 16/09/2026


## Séance n° 1

* 16/09/2026 de 13H00 à 16H00

* Travail effectué :
    - Appropriation du sujet
    - Prise en main de VBoxManage
    - Écriture d'un script basique de création de VM

* A faire à la prochaine séance
    - Ajouter du commentaire (très important)
    - Améliorer le script en ajoutant une verification qu’une machine de meme nom n’existe pas deja.


* Difficultés rencontrées
    - Difficulté à trouver les commandes VBoxManage et à comprendre comment parametrer un DD

* Remarques sur la séances (membre absent, pbe technique, ...)
    - Aucune remarque

* Documentation utilisée :
    - https://forum.ubuntu-fr.org/viewtopic.php?id=439063
    - https://youtu.be/P5l6jdTFUo4?si=mSGxVS8xGo6h7SIn



## Séance n° 2

* 21/09/2026 de 13H00 à 16H00

* Travail effectué :
    - Refonte du script genmv_2.bat pour intégrer des arguments en ligne de commande (L, N, S, D, A) gérant la création, la suppression, le démarrage, l'arrêt et le listage des machines virtuelles.
    - Implémentation des métadonnées
    - Correction du ciblage du stockage : le disque virtuel (.vdi) est désormais correctement créé et attaché avec un chemin absolu dans le dossier par défaut de VirtualBox
    - Ajout d'une gestion des erreurs. Affichage de messages d'erreur en cas de problème.
    - Création de deux fichiers .bat pour ajouter ou retirer genmv_3.bat (son dossier) au path 

* A faire à la prochaine séance
    - Pas de prochaine séance


* Difficultés rencontrées
    - Échec de la configuration du boot PXE via le serveur TFTP interne de VirtualBox

* Remarques sur la séances (membre absent, pbe technique, ...)
    - 1h30 de perdu à essayer de faire marcher PXE et TFTP

* Documentation utilisée :
    - https://forum.ubuntu-fr.org/viewtopic.php?id=439063
    - https://youtu.be/P5l6jdTFUo4?si=mSGxVS8xGo6h7SIn

