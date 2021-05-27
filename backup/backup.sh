#!/bin/bash

# VARIABLEN - HIER EDITIEREN
BACKUP_PFAD="/mnt/myBackupDrive/backup/pi4_dd"
BACKUP_ANZAHL="25"
BACKUP_NAME="ServerPiBackup"
DIENSTE_START_STOP="service mysql"
LOG=/home/pi/log/trim.log
# ENDE VARIABLEN

# Zuvor SD Karte per Trim aufräumen um Backup kleinstmöglich zu halten.
# Leerzeichen beim ersten ECHO um ein besser lesbares Log zu erhalten.
# corn befehl 
# #15  2  1-31/2 * *              /home/debian/bin/backup.sh 2>&1 | tee -a /home/debian/log/pi4_dd.log
# wen mailversand einrichten wenn gewünscht. 

echo "*** $(date -R) ***" | tee -a $LOG
echo
sudo /sbin/fstrim -av | tee -a $LOG
echo >> $LOG

# Stoppe Dienste vor Backup
#${DIENSTE_START_STOP} stop

# Backup mit Hilfe von dd erstellen und im angegebenen Pfad speichern

# MB = 1000
# M  = 1024
# bs=512  count=30670379 30672896
# bs=4096 count=3833798 3834112
# bs=8192 count=1916899 1917056
# bs=4096 count=2688000 bei 10GB 
# count = partitionsgröse oder gesamte sd karte dann ohne count 
# "bs=4096" und "-b 4096" belassen. erhöht die geschwindigkeit etwas.

#sudo dd bs=1MB if=/dev/mmcblk0 | pigz > ${BACKUP_PFAD}/${BACKUP_NAME}-$(date +%Y-%m-%d__%H-%M-%S).img.gz
#sudo dd bs=1MB conv=sync,noerror count=16000 if=/dev/mmcblk0 | pigz > ${BACKUP_PFAD}/${BACKUP_NAME}-$(date +%Y-%m-%d__%H-%M-%S).img.gz
sudo dd bs=4096 conv=sync,noerror count=2688000 if=/dev/sda | pigz -1 -b 4096 > ${BACKUP_PFAD}/${BACKUP_NAME}-$(date +%Y-%m-%d__%H-%M-%S).img.gz


# Starte Dienste nach Backup
#${START_SERVICES} start

# Alte Sicherungen die nach X neuen Sicherungen entfernen
sudo pushd ${BACKUP_PFAD}; ls -tr ${BACKUP_PFAD}/${BACKUP_NAME}* | head -n -${BACKUP_ANZAHL} | xargs rm; popd
echo
echo
