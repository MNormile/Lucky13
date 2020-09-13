#!/bin/bash

cat LogA.txt | sed s/INCORRECTPASSWORD/ACCESSDENIED/ > Update1CombinedAccesslogs.txt
cat Update1CombinedAccesslogs.txt | awk -F" " '{print$4, $6}' > Update2CombinedAccess_logs.txt

