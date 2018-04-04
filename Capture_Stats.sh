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
USERS=`uptime | sed 's/users.*$//' | gawk '{print $NF}'`
LOAD=`uptiem | gawk '{print $NF}'`
#
FREE=`vmstat 1 2 | sed `
