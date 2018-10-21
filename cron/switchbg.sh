#!/bin/bash
filepath=${HOME}/Picture
confFile=${filepath}"/switchbg.conf"
# find $filepath | grep -E ".jpg$|.png$|.JPG$|.PNG$" > $confFile
ls $filepath | grep -E ".jpg$|.png$|.JPG$|.PNG$" > $confFile
cnt=`cat $confFile | wc -l`
while true
do
    line=$(($RANDOM % $cnt + 1))
    bgfile=$(head -n $line $confFile | tail -n 1)
    bgfile="'file://"$filepath"/$bgfile'"
    bkfile=$(gsettings get org.gnome.desktop.background picture-uri)
    if [ $bkfile != $bgfile ]
    then
        break
    fi
done
gsettings set org.gnome.desktop.background picture-uri $bgfile >> tmp.log
