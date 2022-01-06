#! /usr/bin/env bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.24)
timeout=5
res=0

while (($res == 0))
do
    for h in ${hosts[@]}
    do
	curl -I --connect-timeout $timeout $h:80 >/dev/null
	res=$?
	if (($res != 0))
	then
	    echo "    ERROR on " $h status=$res >>hosts2.log
	fi
    done
done



