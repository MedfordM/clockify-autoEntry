#!/bin/bash
# 
# Create time entries on Clockify for every
# weekday since your last entry (Including holidays).
#
# Before running this script you need to install 
# clockify-cli and run 'clockify-cli config init'
#
startTime="08:00"
endTime="17:00"

lastEntryDate=$(clockify-cli show -f "{{.TimeInterval.Start}}" last | cut -d ' ' -f1)
daysSinceLastEntry=$((($(date +%s)-$(date +%s -d $lastEntryDate))/86400))

datesToCreate=()
for (( i=$daysSinceLastEntry-1; i>=0; i-- ))
do
  weekday=$(date +%A -d "-$i days")
  if [ "$weekday" = "Saturday" ] || [ "$weekday" = "Sunday" ]; then
    continue;
  fi
    dateString=$(date +%F -d "-$i days")
    datesToCreate+=("$dateString")
done

echo "Last entry was on $lastEntryDate ($daysSinceLastEntry days ago)"
echo -e "Creating ${#datesToCreate[@]} entries...\n"

for date in "${datesToCreate[@]}"
do
  start="$date $startTime"
  end="$date $endTime"
  clockify-cli clone $lastEntry -s "$start" -e "$end" -f "ID: {{.ID}} | Date: $date | Start: $startTime | End: $endTime" -i=0 last
done
