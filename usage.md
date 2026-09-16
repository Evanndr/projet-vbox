# Rapport SAÉ 51 - Projet VBox
**Auteurs :** NODARI Evan
**Date :** 16 Septembre 2026

## Résumé
Ce document présente notre solution d'automatisation pour la création de machines virtuelles sous VirtualBox via des scripts Batch Windows. Il détaille le fonctionnement de nos scripts (`genmv_X.bat`), les limites actuelles, ainsi que les différents obstacles techniques rencontrés (notamment avec l'hyperviseur de Windows) et la façon dont nous les avons contournés.

## Utilisation
Pour le moment, le projet contient les premières itérations de notre script d'automatisation. 
Pour l'utiliser, il suffit d'exécuter le script `genmv_2.bat` depuis l'invite de commande ou en double-cliquant dessus. 
Le script se charge de :
- Créer une machine virtuelle nommée "test".
- Allouer 4096 Mo de RAM.
- Créer et attacher un disque dur virtuel de 64 GiB.
- Configurer la carte réseau en NAT.
- Mettre le script en pause pour permettre la vérification sur l'interface graphique de VirtualBox, puis supprimer la machine proprement pour nettoyer l'environnement.

## Limites actuelles
- Le script est en cours d'amélioration. 
- La gestion des arguments pour rendre le script totalement non interactif n'est pas encore commencée".

## Astuces techniques utilisées
- Utilisation de variables d'environnement dans le Batch (`set NOM=test`, `%RAM%`) pour rendre les valeurs facilement modifiables en tête de script.
