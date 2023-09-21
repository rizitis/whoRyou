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
echo "─────────────────────────────────────────────────────────────────────────────" > "/tmp/$pkgvar.whoRyou"
print_heading "Hello Slacker, here's the information for package '$pkgvar':" >> "/tmp/$pkgvar.whoRyou"
echo "─────────────────────────────────────────────────────────────────────────────" >> "/tmp/$pkgvar.whoRyou"

# Package Information
print_info "PACKAGE INFORMATION" "If the package is a service, rc.d print will be at the end." >> "/tmp/$pkgvar.whoRyou"
echo " " >> "/tmp/$pkgvar.whoRyou"
# Package Path
print_info "Package Path" >> "/tmp/$pkgvar.whoRyou"
	which "$pkgvar" >> "/tmp/$pkgvar.whoRyou"
	grep ^bin/"$pkgvar"$ /var/lib/pkgtools/packages/* >> "/tmp/$pkgvar.whoRyou"

# Package Size
print_info "PACKAGE SIZE"  >> "/tmp/$pkgvar.whoRyou"
	echo " " >> "/tmp/$pkgvar.whoRyou"
cd /var/lib/pkgtools/packages/
	ls * | grep "$pkgvar"
read -p 'Copy paste full package name-version-arch_tag if exist or type zero (0) and hit enter: ' fpkg
if [ "$fpkg" = 0 ]; then
  echo ""  >> "/tmp/$pkgvar.whoRyou"
else
  cat "$fpkg"* | grep SIZE >> "/tmp/$pkgvar.whoRyou"
echo " "  >> "/tmp/$pkgvar.whoRyou"
# When and persmissions
print_info "When..what permissions? " >> "/tmp/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
 ls -ltr /var/log/packages/ | grep  "$pkgvar"  >> "/tmp/$pkgvar.whoRyou"
else
 ls -ltr /var/log/packages/ | grep "$fpkg" >> "/tmp/$pkgvar.whoRyou"
fi
echo " " >> "/tmp/$pkgvar.whoRyou"
    # Library Dependencies
print_info "LIBRARY DEPENDENCIES" >> "/tmp/$pkgvar.whoRyou"
	  echo " " >> "/tmp/$pkgvar.whoRyou"
	  ldd "$(which "$pkgvar")" >> "/tmp/$pkgvar.whoRyou"
	  echo "" >> "/tmp/$pkgvar.whoRyou"
# Service Information (empty in this example)
print_info "SERVICE INFORMATION" "" >> "/tmp/$pkgvar.whoRyou"
	  echo " " >> "/tmp/$pkgvar.whoRyou"
	  ls -la /etc/rc.d/ | grep "$pkgvar" >> "/tmp/$pkgvar.whoRyou"
	  echo " "  >> "/tmp/$pkgvar.whoRyou"
  # Is it a Library?
  print_info "IS IT A LIBRARY?" >> "/tmp/$pkgvar.whoRyou"
  echo " " >> "/tmp/$pkgvar.whoRyou"
if [ "$fpkg" = 0 ]; then
    echo " " >> "/tmp/$pkgvar.whoRyou"
  else
    sudo ldconfig -p | grep "$pkgvar" >> "/tmp/$pkgvar.whoRyou"
 fi
fi
echo " " >> "/tmp/$pkgvar.whoRyou"
print_info "If the full package name = 0, then only **PACKAGE INFORMATION** is correct." >> "/tmp/$pkgvar.whoRyou"
print_info "Other info may not be accurate :)" >> "/tmp/$pkgvar.whoRyou"
print_heading "─────────────────────────────────────────────────────────────────────────────" >> "/tmp/$pkgvar.whoRyou"
echo -e "${BOLD}${BLUE}"
clear
cat /tmp/$pkgvar.whoRyou
rm /tmp/*.whoRyou
