#!/bin/bash
#
#Capture_Stats - gather system performence statistics
#####################################################
#set variable
REPORT_FILE=/home/user/Documents/capstat.csv
DATE=`date +%Y%m%d`
TIME=`date +%k:%M:%S`
#
#####################################################
#gather performence statistics
#
USERS=`uptime | sed 's/users.*$//' | gawk '{print $NF}'` ##user number; if only have one user,then sed 's/user.*$//'
LOAD=`uptime | gawk '{print $NF}'`                       ##last 15 min average 
#
FREE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $4}'`
IDLE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $15}'`
#
#####################################################
#send statistics to report file
#
echo "$DATE.$TIME.$USERS.$LOAD.$FREE.$IDLE" >> $REPORT_FILE
#
