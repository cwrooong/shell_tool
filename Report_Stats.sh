#!/bin/bash
#
# report_stats - generates rpt from captured perf stats
#######################################################
#set scrip variables 
#
REPORT_FILE=/home/user/Documents/capstats.csv
TEMP_FILE=home/user/Documents/capstats.html
#
MAIL=`which mutt`
MAIL_TO=user
#
#######################################################
#create report header
#
echo "<html><body><h2>Report for $DATE</h2>" > $TEMP_FILE
echo "<table border=\"1\">" >> $TEMP_FILE
echo "<tr><td>Date</td><td>Time</td><td>User</td>" >> $TEMP_FILE
echo "<td>Load</td><td>Free Memory</td><td>%CPU Idle</td></tr>" >> $TEMP_FILE
#
#######################################################
#place performance stats in report
#
cat $REPORT_FILE | gawk -F. '{
printf "<tr><td>%s</td><td>%s</td><td>%s</td>",$1, $2, $3;
printf "<td>%s</td><td>%s</td><td>%s</td>\n</tr>\n",$4, $5,$6;
}' >> $TEMP_FILE
#
echo
echo "</table></body></html>" >> $TEMP_FILE
#
#######################################################
#mail performance report & clean up
#$MAIL -a $TEMP_FILE -s "performance report $DATE"
#--$MAIL_TO < /dev/null
#
#rm -f $TEMP_FILE
#




