#!/bin/bash

# Anagnostakis Ioannis 2023
# GNU GENERAL PUBLIC LICENSE
# LONG LIVE SLACKWARE

if [ "root" != "$USER" ]; then
  echo "Enter su"
  su -c "$0" root
  exit
fi

# Define color codes and formatting
BOLD="\e[1m"
BLUE="\e[34m"
RESET="\e[0m"
UNDERLINE="\e[4m"
GREEN="\e[32m"

# Function to display section headings
print_heading() {
    echo -e "${UNDERLINE}${BOLD}${BLUE}$1${RESET}"
}

# Function to display package information
print_info() {
    echo -e "📦 **$1**\n$2"
}

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
echo -e "${RESET}"

read -p 'Enter package name: ' pkgvar

clear
echo "─────────────────────────────────────────────────────────────────────────────" > "/dev/shm/$pkgvar.whoRyou"
print_heading "Hello Slacker, here's the information for package '$pkgvar':" >> "/dev/shm/$pkgvar.whoRyou"
echo "─────────────────────────────────────────────────────────────────────────────" >> "/dev/shm/$pkgvar.whoRyou"

# Package Information
print_info "PACKAGE INFORMATION" "If the package is a service, rc.d print will be at the end." >> "/dev/shm/$pkgvar.whoRyou"
echo " " >> "/dev/shm/$pkgvar.whoRyou"
# Package Path
print_info "Package Path" >> "/dev/shm/$pkgvar.whoRyou"
	which "$pkgvar" >> "/dev/shm/$pkgvar.whoRyou"
	grep ^bin/"$pkgvar"$ /var/lib/pkgtools/packages/* >> "/dev/shm/$pkgvar.whoRyou"

# Package Size
print_info "PACKAGE SIZE"  >> "/dev/shm/$pkgvar.whoRyou"
	echo " " >> "/dev/shm/$pkgvar.whoRyou"
cd /var/lib/pkgtools/packages/
	ls * | grep "$pkgvar"
read -p 'Copy paste full package name-version-arch_tag if exist or type zero (0) and hit enter: ' fpkg
if [ "$fpkg" = 0 ]; then
  echo ""  >> "/dev/shm/$pkgvar.whoRyou"
else
  cat "$fpkg"* | grep SIZE >> "/dev/shm/$pkgvar.whoRyou"
echo " "  >> "/dev/shm/$pkgvar.whoRyou"
# When and persmissions
print_info "When..what permissions? " >> "/dev/shm/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
 ls -ltr /var/log/packages/ | grep  "$pkgvar"  >> "/dev/shm/$pkgvar.whoRyou"
else
 ls -ltr /var/log/packages/ | grep "$fpkg" >> "/dev/shm/$pkgvar.whoRyou"
fi
echo " " >> "/dev/shm/$pkgvar.whoRyou"
    # Library Dependencies
print_info "LIBRARY DEPENDENCIES" >> "/dev/shm/$pkgvar.whoRyou"
	  echo " " >> "/dev/shm/$pkgvar.whoRyou"
	  ldd "$(which "$pkgvar")" >> "/dev/shm/$pkgvar.whoRyou"
	  echo "" >> "/dev/shm/$pkgvar.whoRyou"
# Service Information (empty in this example)
print_info "SERVICE INFORMATION" "" >> "/dev/shm/$pkgvar.whoRyou"
	  echo " " >> "/dev/shm/$pkgvar.whoRyou"
	  ls -la /etc/rc.d/ | grep "$pkgvar" >> "/dev/shm/$pkgvar.whoRyou"
	  echo " "  >> "/dev/shm/$pkgvar.whoRyou"
  # Is it a Library?
  print_info "IS IT A LIBRARY?" >> "/dev/shm/$pkgvar.whoRyou"
  echo " " >> "/dev/shm/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
    echo " " >> "/dev/shm/$pkgvar.whoRyou"
  else
    sudo ldconfig -p | grep "$pkgvar" >> "/dev/shm/$pkgvar.whoRyou"
 fi
fi
echo " " >> "/dev/shm/$pkgvar.whoRyou"
print_info "If the full package name = 0, then only **PACKAGE INFORMATION** is correct." >> "/dev/shm/$pkgvar.whoRyou"
print_info "Other info may not be accurate :)" >> "/dev/shm/$pkgvar.whoRyou"
print_heading "─────────────────────────────────────────────────────────────────────────────" >> "/dev/shm/$pkgvar.whoRyou"
echo -e "${BOLD}${BLUE}"
clear
cat /dev/shm/$pkgvar.whoRyou
rm /dev/shm/*.whoRyou
