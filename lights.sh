#!/bin/bash
#lights, non tested version 0.0.0

#To set the lights in right mode, script call must contain a value
#./lights.sh 0 for red and alarm, 2 for yellow and 3 for green

#Set up all pins to output: red, yellow, green, audio
source gpio 
gpio mode 0 out  
gpio mode 2 out  
gpio mode 3 out  
gpio mode 4 out  

#0, alarm, red & audio
if  [ $1=0 ]
then
while true; do 
    gpio write 0 1
    sleep 0.5
    gpio write 0 2
    sleep 0.5
done  

#2 or other value, scanning, yellow
elif
    gpio write 2 1
then

#3, OK, green
elif  [ $1=0 ]
then
    gpio write 3 1

#other value, problem, blinking all
else
while true; do 
    gpio write 0 1
    gpio write 2 1
    gpio write 3 1
    sleep 0.5
    gpio write 0 0
    gpio write 2 0
    gpio write 3 0
    sleep 0.5
done  


fi
