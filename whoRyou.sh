#!/bin/bash

# copy paste and modifies
# 2023 rizitis
# LONG LIVE SLACKWARE

if [ "root" != "$USER" ]; then
  echo "Enter su"
  su -c "$0" root
  exit
fi


clear
echo -e "\e[1;34m"
cat << "EOF"
                                                        
  ██████  ██▓    ▄▄▄       ▄████▄   ██ ▄█▀ █     █░ ▄▄▄       ██▀███  ▓█████  
▒██    ▒ ▓██▒   ▒████▄    ▒██▀ ▀█   ██▄█▒ ▓█░ █ ░█░▒████▄    ▓██ ▒ ██▒▓█   ▀  
░ ▓██▄   ▒██░   ▒██  ▀█▄  ▒▓█    ▄ ▓███▄░ ▒█░ █ ░█ ▒██  ▀█▄  ▓██ ░▄█ ▒▒███    
 ▒   ██▒▒██░   ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄  ░█░ █ ░█ ░██▄▄▄▄██ ▒██▀▀█▄  ▒▓█  ▄   
▒██████▒▒░██████▒▓█   ▓██▒▒ ▓███▀░▒██▒ █▄░░██▒██▓  ▓█   ▓██▒░██▓ ▒██▒░▒████▒ 
▒ ▒▓▒ ▒ ░░ ▒░▓  ░▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░ ▓░▒ ▒   ▒▒   ▓▒█░░ ▒▓ ░▒▓░░░ ▒░ ░ 
░ ░▒  ░ ░░ ░ ▒  ░ ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░  ▒ ░ ░    ▒   ▒▒ ░  ░▒ ░ ▒░ ░ ░  ░ 
░ ░  ░    ░ ░    ░   ▒   ░        ░ ░░ ░   ░   ░    ░   ▒     ░░   ░    ░    
  ░      ░  ░     ░  ░░ ░      ░  ░       ░          ░  ░   ░        ░  ░ 
                         ░                                             
                                                                        

EOF
echo -e "\e[0m"



read -p 'Enter package name: ' pkgvar
echo "Hello Slacker, package $pkgvar infos are:" > /tmp/"$pkgvar".whoRyou
echo " " >> /tmp/"$pkgvar".whoRyou
echo "====== PATH =======" >> /tmp/"$pkgvar".whoRyou
echo "If package is a service rc.d print ll be at the end" >> /tmp/"$pkgvar".whoRyou
echo " " >> /tmp/"$pkgvar".whoRyou
# https://mirrors.slackware.com/slackware/slackware-current/source/README.TXT
which "$pkgvar" >> /tmp/"$pkgvar".whoRyou
grep ^bin/"$pkgvar"$ /var/lib/pkgtools/packages/* >> /tmp/"$pkgvar".whoRyou
echo " " >> /tmp/"$pkgvar".whoRyou
wait
echo " "  >> /tmp/"$pkgvar".whoRyou
# https://www.linuxquestions.org/questions/slackware-14/is-there-manual-how-to-remove-unnecessary-stuff-from-slackware-4175723178/page3.html#post6418675
echo "======= PACKAGE SIZE ======" >> /tmp/"$pkgvar".whoRyou
clear
wait
cd /var/lib/pkgtools/packages/
ls * | grep "$pkgvar"
read -p 'Copy full package name-version-arch_tag if exist or type zero (0) and hit enter: ' fpkg
if [ "$fpkg" = 0 ]; then
echo ""  >> /tmp/"$pkgvar".whoRyou
else
cat "$fpkg"* | grep SIZE >> /tmp/"$pkgvar".whoRyou
fi
wait
echo " " >> /tmp/"$pkgvar".whoRyou
# that's mine LOL
echo "======== installation package path ==========" >> /tmp/"$pkgvar".whoRyou
if [ "$fpkg" = 0 ]; then
echo ""  >> /tmp/"$pkgvar".whoRyou
else
locate "$fpkg" | grep txz | grep -v .asc >> /tmp/"$pkgvar".whoRyou
fi
echo " "  >> /tmp/"$pkgvar".whoRyou
wait
echo " "
# ah...
echo "====== LIBS ======" >> /tmp/"$pkgvar".whoRyou
ldd "$(which "$pkgvar")" >> /tmp/"$pkgvar".whoRyou
echo "" >> /tmp/"$pkgvar".whoRyou
wait

echo " " >> /tmp/"$pkgvar".whoRyou
# https://www.linuxquestions.org/questions/slackware-14/is-there-manual-how-to_remove_unnecessary-stuff_from_slackware-4175723178/#post6418574

echo "====== SERVICE =======" >> /tmp/"$pkgvar".whoRyou
echo "If package a service rc.d print ll be here" >> /tmp/"$pkgvar".whoRyou
ls -la /etc/rc.d/ | grep "$pkgvar" >> /tmp/"$pkgvar".whoRyou
echo " "  >> /tmp/"$pkgvar".whoRyou
wait
clear
echo " " >> /tmp/"$pkgvar".whoRyou
echo "========== Is it a library ? ============= " >> /tmp/"$pkgvar".whoRyou
if [ "$fpkg" = 0 ]; then
echo " " >> /tmp/"$pkgvar".whoRyou
else
sudo ldconfig -p | grep "$pkgvar" >> /tmp/"$pkgvar".whoRyou
fi
echo " " >> /tmp/"$pkgvar".whoRyou
clear
echo "======================================================="
echo "If full package name = 0 ; then only ====== PATH =======
is correct, other infos probably NOT :) " >> /tmp/"$pkgvar".whoRyou
cat /tmp/"$pkgvar".whoRyou
