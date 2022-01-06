#! /usr/bin/env bash
array_hosts=( 173.194.222.113 192.168.0.1  87.250.250.242 )
for times in {1..5}
do
date >> log
for host in ${array_hosts[@]}
do
curl $host:80
if (($? !=0))
then
echo $host >> error 
#else
#exit
fi
done
done