#!/bin/bash

echo "********************************"
echo "* Bienvenue Sur mon Projet Sys *" 
echo "********************************"
echo "  MAKAZINA AFOUMBI "
echo "     15A764FS      "
 
while :
do

echo "1-Afficher les Information des Utilisateurs Enregistres il ya trois jours"
echo "2-Acquerir, installer et lancer XAMPP"
echo "3-Archiver des elements du repertoire personnel modifies par le user Sodoer il ya deux jours"
echo "4-Afficher les informations sur l'utilisation du disque,du processeur et de la swap "
echo "5-Quitter"


read -p "Que voulez-vous faire?" resp


case $resp in

     1 ) 
       #La liste des utilisateur
	sudo cut -d : -f 1 /etc/passwd>all_users
	
	#repertoires et fichiers de l'utilisateur 
	ls /home>user_foders
	
	while read line 
	do
		while read line1
		do	
		if [ $line == $line1 ] ; then 
		echo $line1>user1
		fi
		done<user_foders
	done<all_users
	sudo find /home/* -type d -ctime 3 -print>userx

	while read line1
	do
	   while read user
	   do 
	      if [ $line1 == '/home/'$user ] ; then
		echo " $user a ete cree il ya 3jour">3days_user.txt
	      fi

	  done<user1 
	done<userx
	cat 3days_users.txt;;
     2 ) echo "tellechagement  de xampp"
	 wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.30/xampp-linux-x64-5.6.30-1-installer.run?from_af=true
	 echo " insatllation "
	 ./xampp-linux-x64-5.6.30-1-installer.run
	
	 sudo su
	#arret du service apache 
	service apache2 stop
	#arret du service ftp
	service proftpd stop
	#demarage de xampp
	/opt/lampp/lampp start;;
     3 )  echo "archivage"
	#archivage des fichier du rep home modifier par le sudoer il ya 2 jours
	mkdir -p /home/makazina/archive
	find /home/makazina/ -type f -mtime 2 -print>/home/makazina/ficmodi
	while read line
	do
	cp $line archive
	done </home/makazina/ficmodi
	tar -czvf archive.tar.gz archive
	#mv archive.tar.gz /media/usb/*/archive.tar.gz
	mv archive.tar.gz /home/makazina/prof/archive.tar.gz ;;
     4 ) echo "les informations sur l'utilisation du disque :"
		df -h |grep /dev/sd
		echo "les informations sur l'utilisation de la memoire et de la swap :"
		free -h ;;
     5 ) exit ;;
     *) echo  "$resp ne corespond a aucun choix"

esac
echo "-------------------------------------"
done
