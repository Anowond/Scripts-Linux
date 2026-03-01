#!/bin/bash

#Ce script fait la sauvegarde d'un dossier source passé en argument vers un dossier
# de destination passé en second argument au format tar.gz

SOURCE=$1
DESTINATION=$2

#Vérification des arguments
if [[ -z $SOURCE ]] || [[ -z $DESTINATION ]]
then
    echo "Un argument est manquant, indiquez un dossier source et un dossier de destination."
    exit 3
fi

#Fonction de vérification de l'éxistence des dossiers
verif_dossier() {
  if [[ ! -d $1 ]]
  then
    echo "Le dossier $1 n'est pas un dossier ou n'éxiste pas."
    exit 2
  fi
}

#Vérification de l'éxistence des dossiers source et destination
verif_dossier $SOURCE
verif_dossier $DESTINATION

#Sauvegarde de la source avec tar
ARCHIVE=$(date +%Y%m%d_%H%M).tar.gz
tar -czf $ARCHIVE $SOURCE
if (( $? == 0 ))
then
  echo "Archive $ARCHIVE créé avec succés."
  mv $ARCHIVE $DESTINATION
else
  echo "Erreur lors de la création de l'archive : $? "
fi
