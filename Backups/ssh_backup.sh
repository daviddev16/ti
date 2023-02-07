#!/bin/bash
files=( "/home/david/eclipse-workspace" "/home/david/IdeaProjects" "/home/david/Área de trabalho" )
destination_folder="C:\CENTER\BACKUPS\MANJARO-DESKTOP"

while getopts u:p:h: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        p) password=${OPTARG};;
        h) hostname=${OPTARG};;
    esac
done

for i in ${!files[@]}
do
    echo "Transferindo ${files[i]} para \""${hostname}\""..."
    sshpass -p "${password}" scp -r -o LogLevel=INFO "${files[i]}" ${username}@${hostname}:"${destination_folder}"
done
echo "Transferencia concluida."
