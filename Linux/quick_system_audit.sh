#!/bin/bash

echo "A quick system audit script"
date
echo ""
echo "Machine Type Info:"
echo $MACHTYPE
echo -e "Uname Info: $(uname -a) \n"
echo -e "IP Info: $(ip addr | head -9 | tail -1) \n"
echo "Hostname: $(hostname -s) "
echo "DNS Servers: "
cat /etc/resolv.conf
echo "Memory Info:"
free
echo -e "\nCPU Info:"
lscpu | grep CPU
echo -e "\nDisk Usage:" 
df -H | head -2
echo -e "\nWho is logged in: \n $(who -a) \n"
