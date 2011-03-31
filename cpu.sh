#!/bin/bash

if [ "$1" = "powersave" ]
then
    cpufreq-set -c 0 -g powersave
    cpufreq-set -c 1 -g powersave
    cpufreq-set -c 2 -g powersave
    cpufreq-set -c 3 -g powersave
else 
    if [ "$1" = "ondemand" ]
    then
	cpufreq-set -c 0 -g ondemand
	cpufreq-set -c 1 -g ondemand
	cpufreq-set -c 2 -g ondemand
	cpufreq-set -c 3 -g ondemand
    else 
	echo 'Argument incorrect'
	exit
    fi
fi

