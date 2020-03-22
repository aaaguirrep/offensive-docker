#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${redColour}[*] Exiting...${endColour}"
    tput cnorm
    exit 0
}

function help() {
    echo -e "\n${yellowColour}[*]${endColour}${grayColour} Usage: ./portsScan.sh${endColour}"
    echo -e "\n\t${purpleColour}t)${endColour}${yellowColour} Target Host: Ip address or domain name${endColour}"
    echo -e "\t${purpleColour}h)${endColour}${yellowColour} Help${endColour}\n"
    exit 0
}

function checkPhase(){
    timeout 2 bash -c "echo > /dev/tcp/$target_host/$1" 2> /dev/null && echo -e "\n\t\t${redColour}[!] ${blueColour}Port $1 - ${greenColour}OPEN${endColour}" &

    if [ $port -eq $counter ]; then
        echo -e "\n\t${yellowColour}[*]${endColour} ${grayColour}$counter scanned ports${endColour}"
        let counter+=1000
    fi
}

function startScan() {
    echo -e "\n${yellowColour}[*]${endColour}${grayColour} Scanning ports on: ${purpleColour}$target_host${endColour}"
    tput civis; counter=1000
    for port in $(seq 1 65535); do
        checkPhase $port
    done
}

# Main function
if [ "$(id -u)" == "0" ]; then
    declare -i param_counter=0; while getopts ":t:h:" arg; do
        case $arg in
            t) target_host=$OPTARG; let param_counter+=1 ;;
            h) help;;
        esac
    done

    if [ $param_counter -ne 1 ]; then
        help
    else
        startScan
    fi  
else
    echo -e "\n${redColour}[*] Script should be run by root${endColour}\n"
fi  