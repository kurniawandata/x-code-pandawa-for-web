#!/bin/bash
#Progammer : Kurniawan. trainingxcode@gmail.com. xcode.or.id.
#Program ini dapat digunakan untuk personal ataupun komersial.
#X-code Media - xcode.or.id / xcodetraining.com
again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " X-code Pandawa for web (Ubuntu 16.04)               ";
echo " Progammer : Kurniawan. xcode.or.id                              ";
echo " Version 1.0.0 - 18/10/2018                                      ";
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=";
echo " Installasi server & konfigurasi                                 ";
echo " [1] Install Apache2, PHP, Mysql-server, phpmyadmin              ";
echo " [2] Install Virtualhost                                         ";
echo " [3] Setting Virtualhost                                         ";
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=";
echo " Log Server                                                      ";
echo " [4] Cek file access.log.*                                       ";
echo " [5] Lihat semua log pengunjung website                          ";
echo " [6] Reboot                                                      ";
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=";
echo " [7] Exit                                                        ";
echo "=================================================================";
read -p " Masukkan Nomor Pilihan Anda antara [1 - 7] : " choice;
echo "";
case $choice in

1)  read -p "Apakah anda mau yakin mau install apache2, php, mysql-server & phpmyadmin ? y/n :" -n 1 -r
    echo  ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo apt-get install apache2
    echo "Apache2 sudah diinstall"
    sudo apt-get install php
    echo "php sudah diinstall"
    sudo apt-get install mysql-server
    echo "MySQL Server sudah diinstall"
    sudo apt-get install phpmyadmin
    echo "PHPMyadmin sudah diinstall"
    fi
    ;;
2)  echo -n "Masukkan alamat domain / subdomain : "
    read namadomain
    if [ -z "$(ls -A /home/$namadomain/*)" ]; then
    echo "Installasi virtualhost dengan domain"
    sudo useradd -m $namadomain
    sudo passwd $namadomain
    sudo mkdir -p /home/$namadomain/public_html
    sudo chown -r $namadomain.$namadomain /home/$namadomain/public_html
    sudo chmod -R 755 /home/$namadomain
    echo "Selamat datang di web x-code pandawa" >> /home/$namadomain/public_html/index.html
    sudo chmod 755 /home/$namadomain/public_html/index.html
    sudo chown $namadomain.$namadomain /home/$namadomain/public/index.html
    sudo cp support/apache2.conf /etc/apache2/
    sudo cp support/domain.conf /etc/apache2/sites-available/$namadomain.conf
    sudo nano /etc/apache2/sites-available/$namadomain.conf
    sudo a2ensite $namadomain.conf
    sudo service apache2 reload
    else
    echo "Domain yang anda masukkan sudah ada"
    fi
    ;;   
3)  echo -n "Masukkan alamat domain / subdomain : "
    read namadomain
    if [ -z "$(ls -A /etc/apache2/sites-available/$namadomain.conf)" ]; then
    echo "Domain tersebut tidak ada, install virtualhost dulu"
    else
    sudo nano /etc/apache2/sites-available/$namadomain.conf
    sudo a2ensite $namadomain.conf
    sudo service apache2 reload
    fi
    ;;
4) if [ -z "$(ls -A /var/log/apache2/access.log*)" ]; then
    echo "Tidak terdeteksi access.log untuk apache2"
    else
    sudo ls -l /var/log/apache2/access.log*
    fi
    ;;

5) if [ -z "$(ls -A /var/log/apache2/access.log)" ]; then
    echo "Tidak terdeteksi access.log untuk apache2"
    else
    sudo nano /var/log/apache2/access.log
    fi
    ;;

6) read -p "Apakah anda yakin akan restart? y/n :" -n 1 -r
    echo 
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    reboot
    fi
    ;;

7) exit
    ;;
*)    echo "Maaf, menu tidak ada"
esac
echo ""
echo "X-code Pandawa for web"
echo "Oleh Kurniawan - trainingxcode@gmail.com. xcode.or.id"
echo ""
echo -n "Kembali ke menu? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Masukkan yang anda pilih tidak ada di menu";
echo -n "Kembali ke menu? [y/n]: ";
read again;
done
done
