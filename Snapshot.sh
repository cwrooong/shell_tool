#!/bin/bash
#
#Snapshot_Stats
################################################
#set scrip variables
#
DATE=`date+%Y%m%d`
DISKS_TO_MONISTOR="/dev/sda1 /dev/sda2"
#MAIL=`which mutt`
#MAIL_TO=user
REPORT=/home/user/Documents/Snapshot_Stats_$DATA.rpt
#
################################################
#create report file
#
exec 3>$1 #save file descriptor
exec 1>$REPORT #derict output to rpt file
#
################################################
#
echo
echo -e "\t\tDaily System Report"
echo
#
################################################
echo -e "Today is $DATE" #echo -e "Today is `date +%Y%m%d`"
echo
#
################################################
#step 1:gather system uptime statistics
#
echo "System has been \c"
uptime | sed -n '/,/s/,/ /gp' | gawk '{if($4=="days"||$4=="day"){print $2,$3,$4,$5}else{print $2,$3}}'
#
################################################
#step 2:gather disk usage statistics
#
ehco 
for DISK in DISKS_TO_MONISTOR
do
  echo -e "$DISK usage: \c"
  df -h $DISK | sed -n '/% \//p' | gawk '{print $4}'
done
#
################################################
#step 3:gather memory usage statistics
#
echo
free -h | sed -n '2p' | gawk 'x=int(($3/$2)*100) {print x}' | sed 's/$/%/'
#
################################################
#step 4:gather the number of zombie process
#
echo
ZOMBIE_CHECK=`ps -al | gawk '{print $2,$4}' | grep Z ` 
#
if [ $ZOMBIE_CHECK == "" ]
then
  echo "no zombie processes"
else
  echo "current zombie processes"
  ps -al | gawk '{print $2,$4}' | grep Z
fi  
echo
################################################
#Restore file Descriptor 
#
exec 1>$3 #restore output to STDOUT
################################################
#e-mail
#$MAIL -a $REPORT -s "system statistics report for $DATE"
##--$MAIL_TO < /dev/null
#
################################################
#clean up
# 
#rm -f $REPORT
