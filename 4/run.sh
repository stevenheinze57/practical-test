#!/bin/bash 

set -e 

unique_ips=()
while read -r line; do
    ip=$(echo $line | cut -d ' ' -f 2)
    if [[ $(echo ${unique_ips[@]} | grep -w $ip) ]]; then 
        echo "Already exists" 
        # TODO: need to increment here 
    else 
        echo "Doesnt exist" 
        unique_ips+=($ip)
        trimmed_ip=$(echo $ip | tr -d '.')
        # TODO: Need to dynamically set the variable value 
        if [ -z ${ip} ]; then 
            declare "$trimmed_ip=0"
        else 
            declare "$trimmed_ip=$trimmed_ip + 1"
        fi 
    fi
done < logfile.txt 

# TODO: Figure out why bash isnt reading the last line of the logfile. 
# (Was able to bandage this by adding a new blank line at the end) 

for ip in "${unique_ips[@]}"; 
do 
    echo ""
    echo $ip 
done 
