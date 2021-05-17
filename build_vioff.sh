#!/bin/bash


cd ..

sudo yarn

echo "step1. webpacking.."
sudo yarn webpack

echo "step2. building image.."
BLADE_BOT_BUILDS_USER=vewdos_firmware_image_builder BLADE_BOT_BUILDS_PASS="}ay(Ss{tq86>" yarn firmware-image --build

sudo usermod -aG docker ${USER} ;su - ${USER}