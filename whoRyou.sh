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
echo "─────────────────────────────────────────────────────────────────────────────" > "/root/$pkgvar.whoRyou"
print_heading "Hello Slacker, here's the information for package '$pkgvar':" >> "/root/$pkgvar.whoRyou"
echo "─────────────────────────────────────────────────────────────────────────────" >> "/root/$pkgvar.whoRyou"

# Package Information
print_info "PACKAGE INFORMATION" "If the package is a service, rc.d print will be at the end." >> "/root/$pkgvar.whoRyou"
echo " " >> "/root/$pkgvar.whoRyou"
# Package Path
print_info "Package Path" >> "/root/$pkgvar.whoRyou"
	which "$pkgvar" >> "/root/$pkgvar.whoRyou"
	grep ^bin/"$pkgvar"$ /var/lib/pkgtools/packages/* >> "/root/$pkgvar.whoRyou"

# Package Size
print_info "PACKAGE SIZE"  >> "/root/$pkgvar.whoRyou"
	echo " " >> "/root/$pkgvar.whoRyou"
cd /var/lib/pkgtools/packages/
	ls * | grep "$pkgvar"
read -p 'Copy paste full package name-version-arch_tag if exist or type zero (0) and hit enter: ' fpkg
if [ "$fpkg" = 0 ]; then
  echo ""  >> "/root/$pkgvar.whoRyou"
else
  cat "$fpkg"* | grep SIZE >> "/root/$pkgvar.whoRyou"
echo " "  >> "/root/$pkgvar.whoRyou"
# When and persmissions
print_info "When..what permissions? " >> "/root/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
 ls -ltr /var/log/packages/ | grep  "$pkgvar"  >> "/root/$pkgvar.whoRyou"
else
 ls -ltr /var/log/packages/ | grep "$fpkg" >> "/root/$pkgvar.whoRyou"
fi
echo " " >> "/root/$pkgvar.whoRyou"
    # Library Dependencies
print_info "LIBRARY DEPENDENCIES" >> "/root/$pkgvar.whoRyou"
	  echo " " >> "/root/$pkgvar.whoRyou"
	  ldd "$(which "$pkgvar")" >> "/root/$pkgvar.whoRyou"
	  echo "" >> "/root/$pkgvar.whoRyou"
# Service Information (empty in this example)
print_info "SERVICE INFORMATION" "" >> "/root/$pkgvar.whoRyou"
	  echo " " >> "/root/$pkgvar.whoRyou"
	  ls -la /etc/rc.d/ | grep "$pkgvar" >> "/root/$pkgvar.whoRyou"
	  echo " "  >> "/root/$pkgvar.whoRyou"
  # Is it a Library?
  print_info "IS IT A LIBRARY?" >> "/root/$pkgvar.whoRyou"
  echo " " >> "/root/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
    echo " " >> "/root/$pkgvar.whoRyou"
  else
    sudo ldconfig -p | grep "$pkgvar" >> "/root/$pkgvar.whoRyou"
 fi
fi
echo " " >> "/root/$pkgvar.whoRyou"
print_info "If the full package name = 0, then only **PACKAGE INFORMATION** is correct." >> "/root/$pkgvar.whoRyou"
print_info "Other info may not be accurate :)" >> "/root/$pkgvar.whoRyou"
print_heading "─────────────────────────────────────────────────────────────────────────────" >> "/root/$pkgvar.whoRyou"
echo -e "${BOLD}${BLUE}"
clear
cat /root/$pkgvar.whoRyou
rm /root/*.whoRyou
