# Przygotowanie środowiska dev na windows 10 enterprise + hyper v + ubuntu 20.04

1. Instalacja ubuntu 20.04 - można zrobić quick start - wersja 20.04 jest już dostępna
Należy pamiętać o zwiększeniu rozmiaru partycji (Edit disk w hyperv + gparted w ubuntu)

2. Enhanced mode - polaczenie przez xrdp

18.04 ma uruchomioną usługe xrdp domyślnie
dla 20.04 na razie nalezy:

https://askubuntu.com/questions/1246362/how-to-setup-xrdp-for-ubuntu-20-04-in-windows-hyper-v
Czyli:

a) Wyłączyć autologin

b) Pobierz skrypt wlaczajacy xrdp 
wget https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/20.04/install.sh
sudo chmod +x install.sh
sudo ./install.sh

c) Set-VM -VMName <your_vm_name> -EnhancedSessionTransportType HvSocket

c) Może być konieczne wejście do /etc/xrdp/xrdp.ini i zmiana use_vsock na false (jak na poniższym filmiku) inaczej nie odpalisię połączenie xrdp i rozszerzona sesja
A dodatkowo w sekcji xorg ustawić domyślnego użytkownika (wtedy będzie wymagał tylko hasła przy podłaczaniu do maszyny)

https://www.youtube.com/watch?v=tW7BHCZR8k4

3. Czcionki - skalowanie czcionek na razie nie działa więc nalezy obejść to :

https://askubuntu.com/questions/1276310/how-to-change-font-display-size
sudo apt install gnome-tweaks

Dla interfacu vs code: https://stackoverflow.com/questions/57008558/how-to-change-the-font-of-visual-studio-codes-ui

4. VPN - 
94.42.122.100

Należy doinstalować L2TP:
https://www.tecmint.com/setup-l2tp-ipsec-vpn-client-in-linux/
$ sudo add-apt-repository ppa:nm-l2tp/network-manager-l2tp
$ sudo apt-get update
$ sudo apt-get install network-manager-l2tp  network-manager-l2tp-gnome

W wypadku gdyby VPN nie chciał się podłączyć należy sprawdzić logi /var/log/syslog
Prawdopodobnie problem będzie leżał po stronie bibliotek dostrczających algorytmy szyfrujące.
Usunięcie libreswan i zastąpie go stronswan może pomóc.
https://askubuntu.com/questions/1185423/ubuntu-19-10-l2tp-vpn-doesnt-work-anymore
I had the exact same problem upgrading from 19.04 to 19.10. I tried the NetworkManager upgrade too, but that didn't solve my problem. I then did the following three things, and now everything works again:

Replaced libreSwan with StrongSwan (I found if I purged libreSwan, StrongSwan was automatically installed)
Explicitly specified the Phase 1 and Phase 2 algorithms: "3des-sha1-modp1024" and "3des-sha1" respectively.
Ensured only MSCHAPv2 was checked under PPP Settings.
I have a feeling #3 is what solved my problem as I did notice a few more authentication boxes were checked under PPP Settings after the upgrade.

5. Synchronizacja vscode - instalujemy sync extension - podłączamy się do git hub i ściągamy ustawienia (polecenie Sync: Download)
Instalujemy git (sudo apt install git)
Włączamy zapamiętywanie haseł: git config --global credential.helper store (uwaga może być niebezpiecznie bo hasła nie są szyfrowane!)

Sprawdzamy czy jest ustawione "keyboard.dispatch": "keyCode" (inaczej prawy alt będzie działał jak strzałka) 
https://github.com/Microsoft/vscode/wiki/Keybinding-Issues#troubleshoot-linux-keybindings


6. Logowanie do repozytorium git: git.******.com (projekt ecommerce)
Ściągamy https://git.dysant.com/gerant/ecommerce

7. Instalacja zsh / oh-my-zsh

https://www.tecmint.com/install-zsh-in-ubuntu/
https://www.tecmint.com/install-oh-my-zsh-in-ubuntu/

8. Instalacja VIM 
a) sudo apt install VIM 
b) Towrzymy katalog  .vim/colors w home folder (~)

9. Ściągnięcie zapisanych dofiles z github

https://github.com/wojciechklicki/env-config
Wrzucamy do katalogu dev (np. ~/dev/env-config)

Po ściągnięciu wywołujemy install.sh
Instalujemy ctags/cscope/tmux (sudo apt install ctags cscope tmux)
Instalujemy vundle dla VIM https://github.com/VundleVim/Vundle.vim
Wchodzimy do VIM i instalujemy pluginy :
	Launch vim and run :PluginInstall
	To install from command line: vim +PluginInstall +qall

Instalujemy z (https://github.com/rupa/z) w /bin/tools/z.sh

10. Instalacja node / npm / nvm
Najpierw nvm
https://github.com/nvm-sh/nvm

Przełączamy się na node 12 
nvm install 12
nvm use 12

11. Instalujemy mongo db
https://computingforgeeks.com/how-to-install-latest-mongodb-on-ubuntu/
Najpierw dodajemy repozytorum mongo do listy (inaczej będzie nam stalował tylko wersję 3)
a)wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
b)echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
c) sudo apt update

I instalujemy : sudo apt install -y mongodb-org
sudo systemctl enable --now mongod

instalujemy compass:
https://docs.mongodb.com/compass/current/install/

12. Skrót do maszyn virtualnych:

https://winaero.com/create-hyper-v-connection-shortcut-windows-10/

13. CopyQ do zarządania schowkiem:
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo apt install copyq
