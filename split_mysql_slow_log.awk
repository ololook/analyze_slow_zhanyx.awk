#!/bin/sh
statnum=`date -d "$1" +%s`
endnum=`date -d "$2" +%s`
awk -v stime=$3 '{if ($0 ~ /^SET timestamp/)
        {if(int(substr($2,11,10))<='"$endnum"' && int(substr($2,11,10))>='"$statnum"')
             { host = 1;}
        else { host = 0;}
        }
        if ($0 ~/^# Query_time/)
            {if ($3>stime)
                {query=1;}
        else    {query=0;}
            }
if (host == 1&& query==1) { print $0;}
     else  if (int(substr($2,11,10))>'"$endnum"') {exit;}}' $4