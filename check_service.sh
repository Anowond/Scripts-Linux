#!/bin/bash

#Ce script vérifie si un service systéme est actif ou non.
# Syntaxe : check_service.sh <nom_service>
SERVICE=$1

#Fonction de vérification du service passé en argument
verif_service_arg () {
	if [[ ! $SERVICE ]]
	then
		echo "Service non spécifié, indiquez un service en argument."
		exit 3
	fi
}

#Fonction de vérification de l'existence du service
verif_service_exists () {
	systemctl status $SERVICE &> /dev/null

	if (( $? == 4 ))
	then
		echo "Le service indiqué n'éxiste pas."
		exit 2
	fi
}

verif_service_arg
verif_service_exists

#Traitement du service
systemctl is-active $SERVICE &> /dev/null
if (( $? == 0 ))
then
	echo "Service $SERVICE actif."
	exit 0
else
	echo "Service $SERVICE incatif."
	exit 1
fi
