#!/bin/bash
default_hosts=("google.com" "github.com" "amrita.edu" "linkedin.com")
read -p "Enter additional hostname or IP's(space-seperated): " -a user_hosts
all_hosts=("${default_hosts[@]}" "${user_hosts[@]}")
log_file="ping_log.txt"
down_log="down_log.txt"
echo -e "\n Checking network status for all hosts...\n"
for host in "${all_hosts[@]}"
do
  if ping -c 1 "$host" > /dev/null 2>&1
  then
    echo -e "\e[32m$(date): $host is UP\e[0m"  | tee -a "$log_file"
        last_down=$(grep "$host" "$down_log"  | tail -1)
              if [ -n "$last_down" ]; then
                 echo -e " Last time it was DOWN: $last_down"
                        fi
               else
              echo -e "\e[31m$(date): $host is DOWN\e[0m"  |  tee -a "$log_file"
               echo "$(date): $(date): $host" >> "$down_log"
         fi
done
