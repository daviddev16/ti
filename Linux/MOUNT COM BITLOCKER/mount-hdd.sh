#!/bin/bash

if [[ ! $(pacman -Qs 'dislocker') ]];
then
      echo "Dislocker não encontrado"
      exit
fi

while getopts p:d:f: flag
do
    case "${flag}" in
        d) partition=${OPTARG};;
        p) password=${OPTARG};;
        f) folder=${OPTARG};;
    esac
done

echo "Montando HD com BitLocker do Windows"

mount_folder="${folder}mount"

sudo dislocker "${partition}" -u"${password}" -- "${folder}"
sudo mount -o loop "${folder}/dislocker-file" "${mount_folder}"

echo "Montado em \"${mount_folder}\"."
