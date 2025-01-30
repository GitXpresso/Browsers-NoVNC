# Browsers-NoVNC
Every browser in a novnc server, plain bash no docker. Does not support audio
## Table of Contents
>[!IMPORTANT]
> A astrisk(*) next to the anchored link means the contents has not been added yet, or it has the header but doesn't have the contents
>
> 2 astrisks(*) means that the image of what the browser looks like in the NoVNC session has not been added yet
>
> 3 astrisks(*) next to the anchored link means that the browser logo and about the browser has not been added yet
>
> 4 astrisks(*) next to the anchored link means that it neither has the about the browser, browser logo, and image of the what browser looks like in the NoVNC server session
>
> No Asterisks(*) next to the anchored link means it has the about the browser, logo of the browser, and what the browser looks like in NoVNC session

  
<details><summary>Tasks</summary>
  
`Brave does not work but it does work in a linuxserver openbox kasmvnc session`

- [ ] add link to video pn how to have waterfox noVNC automatically start on boot
- [ ] add all the browsers
- [ ] finish adding all service files 
- [ ] use winehq to install browsers that dont work 
- [ ] use winehq to have opera gx in a browser
- [ ] Contact [@thelamer](https://github.com/thelamer) to see if he he can make a linuxserver kasmvnc docker container for the following browsers
> [!NOTE]
> There are desktop files you can use for the linuxserver kasmvnc docker container for the browsers


`List of browsers to be in a linuxserver in a kasmvnc docker container`

- Brave creates a /usr/share/hicolor/apps/48x48/brave.png
- Tor Browser which is a proot app in the linux server repository "proot apps"
- Google Chrome 
- Falkon
- Waterfox have to create a desktop file for the container and use the tar file
- Zen need to create desktop file 
- Seamonkey 
- Icecat
- Palemoon
- Floorp
- Midori
 
</details>

<details><summary>Google browsers</summary>

- [Chrome NoVNC](#Chrome-NoVNC) ✔️
- [Chromium NoVNC](#Chromium-NoVNC) ✔️

</details>

<details><summary>Chromium Based Browsers</summary>
  
- [Srware Iron NoVNC](#Srware-Iron-NoVNC) ❌ crash after a couple seconds when launched
- [Thorium NoVNC](#Thorium-NoVNC) ✔️
- [Brave NoVNC](#Brave-NoVNC) ✔️
- [Microsft Edge NoVNC](#Microsoft-Edge-NoVNC) ✔️
- [Opera NoVNC](#Opera-NoVNC) ✔️
- [Vivaldi NoVNC](#Vivaldi-NoVNC) ✔️
  
</details>

<details><summary>Mozilla Browsers</summary>
  
- [Firefox NoVNC](#Firefox-NoVNC) ✔️
- [Seamonkey NoVNC](#Seamonkey-NoVNC) ✔️

</details>

<details><summary>Firefox Based Browsers</summary>
  
- [Librewolf-NoVNC](#Librewolf-NoVNC) ✔️
- [Floorp NoVNC](#Floorp-NoVNC) ✔️
- [Tor NoVNC](#Tor-NoVNC) ✔️
- [Mullvad NoVNC](#Mullvad-NoVNC) ✔️
- [Waterfox NoVNC](#Waterfox-NoVNC)
- [Icecat NoVNC](#Icecat-NoVNC) ✔️
- [Zen Novnc](#Zen-NoVNC) ✔️
- [Pale Moon NoVNC](#Pale-Moon-NoVNC) ✔️
- [Midori NoVNC](#Midori-NoVNC) ✔️
- [Pulse NoVNC](#Pulse-NoVNC) ✔️
- [Basilisk NoVNC](#Basilisk-NoVNC) ✔️

</details>

<details><summary>Other</summary>
  
- [Similar Projects I making](#Similar-Projects-Im-making)
- [Set Default x-www-browser](#Set-Default-x-www-browser)

</details>

- [Qutebrowser NoVNC](#Qutebrowser-NoVNC) ✔️
- [Falkon NoVNC](#Falkon-NoVNC) ✔️



# Chrome NoVNC

<br/>
<div align="center">
  <a href="https://google.com/chrome">
    <img src="https://upload.wikimedia.org/wikipedia/commons/e/e1/Google_Chrome_icon_%28February_2022%29.svg" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Google Chrome </h3>

  <p align="center">
       Google Chrome is a web browser developed by Google.
    <br/>
</div>

## Run Chrome NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Chrome NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/chromenovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit chrome service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/chromeservice /etc/init.d/chromenovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/chromenovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/chrome
#!/bin/bash
sudo service chromenovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/chrome /etc/profile.d
```
## What Chrome looks like
![](screenshots/chrome.png)
# Brave NoVNC

<div align="center">
  <a href="https://brave.com">
    <img src="https://static.wikia.nocookie.net/logopedia/images/9/9d/Brave_lion.svg" alt="Logo" width="170" height="200">
  </a>
  <h1 align= "center">Brave</h1>
    <br/>
<h3 center "left">Free and open-source web browser developed by Brave Software, Inc. based on the Chromium web browser</h3>
</div>

## Run Brave NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Brave NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/bravenovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit brave service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/braveservice /etc/init.d/bravenovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/bravenovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/brave
#!/bin/bash
sudo service bravenovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/brave /etc/profile.d
```
## What Brave looks like
![](screenshots/brave.png)
# Chromium NoVNC
<br/>
<div align="center">
  <a href="https://librewolf.net">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Chromium_Logo.svg/512px-Chromium_Logo.svg.png" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Chromium </h1>
    <br/>
<h3 center "left">Chromium is a free and open-source web browser project developed primarily by Google, which serves as the foundation for Google Chrome and many other browsers. It is known for its speed, security, and stability, and is widely used in various applications and frameworks.</h3>
</div>

## Run Chromium NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Chromium NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/chromiumnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit chromium service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/chromiumservice /etc/init.d/chromiumnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/icecatnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/chromium
#!/bin/bash
sudo service chromiumnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/chromium /etc/profile.d
```
## What Chromium looks like
![](screenshots/chromium.png)
# Thorium NoVNC
<br/>
<div align="center">
  <a href="https://thorium.rocks">
    <img src="https://thorium.rocks/imgs/thorium.svg" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Thorium </h1>
    <br/>
<h3 center "left">Thorium Browser is a fast, open-source web browser based on Chromium, designed to improve performance and usability. It is available on multiple platforms, including Windows, macOS, Linux, and Android, and aims to provide a more efficient browsing experience compared to standard Chromium.</h3>
</div>

## Run Thorium NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Thorium NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/thoriumnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit thorium service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/thoriumservice /etc/init.d/thoriumnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/thoriumnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/thorium
#!/bin/bash
sudo service thoriumnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/thorium /etc/profile.d
```
## What Thorium looks like
![](screenshots/thorium.png)
# Librewolf NoVNC
<br/>
<div align="center">
  <a href="https://librewolf.net">
    <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/LibreWolf_icon.svg" alt="Logo" width="200" height="200">
  </a>
  <h1 align= "center">Librewolf </h1>
    <br/>
<h3 center "left">LibreWolf is a free and open-source fork of Firefox, with an emphasis on privacy and security. </h3>
</div>

## Run Librewolf NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Librewolf NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/librewolfnovnc.sh | bash
```
## What Librewolf looks like
![librewolf.png](<https://media-hosting.imagekit.io//3ade5c80c0e14121/librewolf.png?Expires=1831853978&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=anK-bXP9pP7p1jcpXZ~7yXNfArP-W7OalWcKHVCWZ7WG7dXaoJyu0jGAVhLRrh1N56aXV6TMtAAbVlOKACJd7qi6d0x3bkKNBARikw1qwNEKDttcSxWWcmwVVJRQ5XN89neGibVItk2FSnMulx92G3H~PukAzLIbD5j1Seti4CJmAcYbrIliNVZ3VHaoVu4KKSANPyOiIvn8Diy9dxj-Fwr0PscdMvzWQzOP4iVjv3znVUVKixbuPjsOuHTnEX-Qpi9Ia-MHaGMZmw-F8CDswKBF8ubRLE0KehVtSarENSCO~jjF9BPFbO7jOBzfMjavg1wJMPzbnviXs77oD5TyOw__>)
# Microsoft Edge NoVNC
<br/>
<div align="center">
  <a href="https://microsoft.com">
    <img src="https://upload.wikimedia.org/wikipedia/commons/9/98/Microsoft_Edge_logo_%282019%29.svg" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Microsoft Edge</h1>
    <br/>
<h3 center "left">Microsoft Edge is a web browser developed by Microsoft, designed to replace Internet Explorer. It is built on the Chromium open-source project and offers features like AI integration, vertical tabs, and a built-in VPN for enhanced browsing experiences.</h3>
</div>

## Run Microsoft Edge NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Microsoft Edge NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/edgenovnc.sh | bash
```
## What Microsoft Edge looks like
![](screenshots/edge.png)
# Librewolf NoVNC
<br/>
<div align="center">
  <a href="https://librewolf.net">
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/3d/Basilisk_Web_Browser_Logo.png?20171118151021" alt="Logo" width="239" height="200">
  </a>
    <br/>
<h3 center "left">Basilisk is an updated fork of Firefox designed to look and feel similar to versions before the underlying backend was changed in version 57.</h3>
</div>

## Run Basilisk NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Basilisk NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/basilisknovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit basilisk service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/basiliskservice /etc/init.d/basilisknovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/basilisknovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/basilisk
#!/bin/bash
sudo service basilisknovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/basilisk /etc/profile.d
```
## What Basilisk looks like
![](screenshots/basilisk.png)
# Falkon NoVNC
<br/>
<div align="center">
  <a href="https://falkon.org">
    <img src="https://upload.wikimedia.org/wikipedia/commons/5/57/Breezeicons-apps-48-falkon.svg" alt="Logo" width="130" height="130">
  </a>
  <h1 align= "center">Falkon</h1>
    <br/>
<p center "left">Falkon is a free and open-source web browser developed by KDE, originally known as QupZilla. It is built on the Qt WebEngine and is designed to be lightweight, offering features like a built-in ad blocker and integration with desktop environments.</p>
</div>

## Run Falkon NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Falkon NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/falkonnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit falkon service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/falkonservice /etc/init.d/falkonnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/falkonnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/falkon
#!/bin/bash
sudo service falkonnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/falkon /etc/profile.d
```
## What Falkon looks like
![falkon.png](<https://media-hosting.imagekit.io//032559a8ffc848cf/falkon.png?Expires=1831928501&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=C3dpIdsOwRWSWbODi4DdeGNaAm-zA8RGxrymqNpEFPUr~2pL4mtCDOeGryJG24EApXQ0YnGPu2zkgSBARvUW5qWyGTs3DLtTyIlsQ5FjMxQdN8OJMpfalZWiihzYnSMwoVUxj85Ylo8ps8fYEvhIzSTq1dU~Mfn~U9~Rg8xAWD0LYbqwpr0~az4b5ZzSb9d0Ex4QXkjH-RGJ4UdAxe~icC3Dlrii0-a799mzeBxO-9-VF1RKSaM29PiHx1SWborhh7lU0GnivmBwxouC09Mk8u4ToJYgbdATdRwrrW6xdfLD0fiUpdDK~gUEUyDCXj9X35ey9AIEQE-G-GUAvKu7dA__>)
# Opera NoVNC
<br/>
<div align="center">
  <a href="https://opera.com">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Opera_2015_icon.svg/800px-Opera_2015_icon.svg.png" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Opera</h1>
    <br/>
<p center "left"> </p>
</div>

## Run Opera NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Opera NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/operanovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit opera service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/operaservice /etc/init.d/operanovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/operanovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/opera
#!/bin/bash
sudo service operanovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/opera /etc/profile.d
```
## What Opera looks like
![](screenshots/opera.png)
# Floorp NoVNC
<!-- PROJECT LOGO -->
<br/>
<div align="center">
  <a href="https://github.com/Floorp-Projects/Floorp">
    <img src="https://avatars.githubusercontent.com/u/94953125?s=200&v=4" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Floorp </h3>

  <p align="center">
       A Browser built for keeping the Open, Private and Sustainable Web alive. Based on Mozilla Firefox.
    <br/>
</div>
    
## Run Floorp NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Floorp NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/floorpnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit floorp service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/floorpservice /etc/init.d/floorpnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/floorpnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/floorp
#!/bin/bash
sudo service floorpnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/floorp /etc/profile.d
```
## What Floorp looks like
![floorp.png](<https://media-hosting.imagekit.io//2d35d6dd0ae54b25/floorp.png?Expires=1831905312&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=A1KJ8kSm63GbVr01gcv53oe4MDe1ky6fS~9D5QTpx0TAWnR8b-zV1JNXrpHGy7h9cUZffmk2SMjHuu3kTxfMEBj6auHmFaxT1M2t0BTKwysMnA12BReO~-3c80FH4NNBOsDDx80afOEKzAGi7WE0ppIsE7NGP34Y2KpGDMNZD9Mdop5~52B1WYCcO8msxGzkITUhFGE-2YfNei6D1W17T0CVHJGJGA-d7BRiuZPMr~LwBUvDKP8v33igxS7S3cFVQ2oU0wHVZ0NSkfMODiJ-y0makTyUF1wmMvdtRKsnUR3kxvicVtPp217U9~gault5QrZ6z1bovjKNQnWbP~nHcA__>)

# Firefox NoVNC

<br/>
<div align="center">
  <a href="https://firefox.com">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Firefox_logo%2C_2019.svg/220px-Firefox_logo%2C_2019.svg.png" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Firefox </h3>

  <p align="center"> Mozilla Firefox is a free and open-source web browser developed by Mozilla
Foundation and its subsidiary, Mozilla Corporate.  </p>
       
   <br/>
</div>

## Install curl if you don't have it

```
sudo apt install curl
```
## Run Firefox NoVNC using curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/firefoxnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit firefox service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/firefoxservice /etc/init.d/firefoxnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/firefoxnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/firefox
#!/bin/bash
sudo service firefoxnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/firefox /etc/profile.d
```
## What Firefox looks like
![](screenshots/firefox.png)
# Seamonkey NoVNC

<br/>
<div align="center">
  <a href="https://seamonkey-project.org">
    <img src="https://i.ibb.co/M80rbs0/default64.png" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Seamonkey </h3>

  <p align="center"> SeaMonkey is a free and open-source Internet suite that includes a web browser, email client, HTML editor, and IRC chat client. </p>
       
   <br/>
</div>

## Run Seamonkey NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Seamonkey NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/seamonkeynovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit seamonkey service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/seamonkeyservice /etc/init.d/seamonkeynovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/seamonkeynovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/seamonkey
#!/bin/bash
sudo service seamonkeynovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/seamonkey /etc/profile.d
```
## What Seamonkey looks like
![seamonkey.png](<https://media-hosting.imagekit.io//f785835a7cf8444d/seamonkey.png?Expires=1831923822&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=arvN69w8dqKRIrZdIyJe7rwTLm7M5N0qnGIKJoOeHeULjwjbSYacmckgB1X3qjRezfcbiAEfORlfQT551yrAgxznCCM8KQfCGMLrQtoukv3CPz9vwZA44mRkMVauSoAQBPXAoxNQZ17I38rFSHyCBw7IViDCs83-K3p-XvuVa8sOb-5TJeZ-mrZUN9ZdYZSd-JZJLEucktK1-lP7jfZkBJymBHb6mrRYCEUVUVPcIXVP91kf4xVmunqV83Rerwn~-NHRafVsp2~7gn5psQ3DcXndJ04WubQv7rnVtUjRYY1GCmkD~JsjeBaDOBIc5TXYYeFolHXZLgF4MHsi0i6a0A__>)

# Waterfox NoVNC

<br/>
<div align="center">
  <a href="https://waterfox.net">
    <img src= "https://upload.wikimedia.org/wikipedia/commons/e/e4/Waterfox_logo_2019.svg" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Waterfox</h3>

  <p align="center">Waterfox is a popular open-source web browser that combines speed, privacy, and customization. With Waterfox, you can enjoy a fast and private browsing experience right out of the box. </p>
       
   <br/>
</div>

## Install curl if you don't have it
```
sudo apt install curl
```
## Run Waterfox NoVNC using curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/waterfoxnovnc.sh | bash
```
### Have Waterfox automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit waterfox service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/waterfoxservice /etc/init.d/waterfoxnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/waterfoxnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/waterfox
#!/bin/bash
sudo service waterfoxnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/waterfox /etc/profile.d
```
## What Waterfox looks like
[![Waterfox Novnc](<https://media-hosting.imagekit.io//076eae515bf74dd4/Screenshot%202025-01-17%2012.11.59%20PM.png?Expires=1831741943&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=cDElZA3hP67r8lIe2Y-1zpqDDujp2GhzpiiRNp3xJ8KxJ97q1LgGJ3FlBY-7GU9cAVWFjdns9sniPocigFThIxKgi06FdefaKVXNXNwniu~h4SPK1uQOD4nu~WElyEZdt7vdcPVcBsLpxmvd26eudE8zEX7WJ8K7A2R~eBHwoB7kWz49lw5euKMguU64zYqJGbOq-EOwxFGKLl-nvDNA7Cu7BwOMwy0D96aUr5aqHOYMgbG8AvxMl5PZOEYKSp5f8d36jAYbg8gyTlxaPdxl2dKnHMyOqJgknD2tXql0e~DcG7kNz9c9RWCy435M4n3cn5fO5NtN2TMYoyf0hx9FnA__>)](https://waterfox.net/)
# Midori NoVNC
<br/>
<div align="center">
  <a href="https://astian.org/en/midori-browser">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Midori.svg/800px-Midori.svg.png" alt="Logo" width="150" height="150">
  </a>
  <h3 align="center">Midori</h3>
   <p align="center">Midori (Japanese: 緑, romanized: midori, lit. 'green') is a free and open-source web browser</p>
</div>

## Run Midori NoVNC
### Install curl if you don't have it
```
sudo apt install curl
```
### Run Midori NoVNC using curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/midorinovnc.sh | bash
```
### Have Midori automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit midori service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/midoriservice /etc/init.d/midorinovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/midorinovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/midori
#!/bin/bash
sudo service midorinovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/midori /etc/profile.d
```
### What Midori looks like
![](screenshots/midori.png)

# Icecat NoVNC
<br/>
<div align="center">
  <a href="https://icecatbrowser.org">
    <img src="https://www.gnu.org/software/gnuzilla/icecat.png" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">GNU Icecat</h3>

  <p align="center">  GNU IceCat is a free and open-source web browser based on Mozilla Firefox, developed by the GNU Project. It emphasizes user privacy and security by removing non-free add-ons and including additional privacy features not found in standard Firefox. </p>
       
   <br/>
</div>

## Run Icecat NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Icecat NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/icecatnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit icecat service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/icecatservice /etc/init.d/icecatnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/icecatnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/icecat
#!/bin/bash
sudo service icecatnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/icecat /etc/profile.d
```
## What Icecat looks like
![icecat.png](<https://media-hosting.imagekit.io//e31e532ff7014497/icecat.png?Expires=1831908720&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=zOAh-yvtqMWn-jqVcCla66chjiBONfjXuvwVjQOM5qxy92HKE2FY~2jwk7UY7AXdLrrpxjfK9Niu-PY0xWKSislPSUxPbQEY2O0nmKKjdl8T1VvIljm6TVk4IO-my2oiw1sAUbPTWpjiwQSvzV7oL6nDhBVGkKCjTR8xpAVvVISsnGjhs~7rC3cAPjDPMf8fHgxgjPBdfp3hwTi6R8hJ1vy6t50Jj5yU74Xjf4uCxJhbe2p4a21U0z1YsRYa8oyJH9brBNY5smdq5stLlN7LjeM39WdlBJvrVYFkjR5YNpUaFmk6ZZgWNO9iCwmF67P1jMGUx2ryxptT~-JabtdMOg__>)
# Mullvad NoVNC
<br/>
<div align="center">
  <a href="https://mullvad.net">
    <img src="https://static.wikia.nocookie.net/logopedia/images/3/35/Mullvad_Browser_2023.png" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Mullvad </h1>
    <br/>
<p center "left">Mullvad Browser is a privacy-focused web browser developed in collaboration with the Tor Project, designed to enhance online privacy by minimizing tracking and fingerprinting. </p>
</div>
  
## Run Mullvad NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Mullvad NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/mullvadnovnc.sh | bash
```
### Have Mullvad automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit mullvad service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/mullvadservice /etc/init.d/mullvadnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/mullvadnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/mullvad
#!/bin/bash
sudo service mullvadnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/mullvad /etc/profile.d
```
## What Mullvad looks like
![mullvad.png](<https://media-hosting.imagekit.io//f4531350ebd246b9/mullvad.png?Expires=1831910992&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=hHikCyhKJxM-AzXSTTdLSq2jTj0fUfHXxgs~S97ly-7lf36yHOKIn4JZ5KB5PjdYQoMkTtkVYG2c36wjueM73c0EgnBXBs500K-cvuzKhLAsjZyGKPhjUGRyi9cxWua~QpCozRolIAYB-QztSz0G~dkQ9-ZHL-0LR-JXlKntR8Hy-WLnj0TXM4t32150kYzWJ5lMeUHpC9DEH6geQkWR6FznOSNv8kw0V1wNMXhhU8xAy~k~0vlCTNYKqOuqxDKKqqf0ipKpWv55pAOyRSF3rJIPjMnORPwXjNR7tEo9ncHBqNzGwEND9yjB3mzM9eBAKD4alxedtYLyADOsAcX6NA__>)
# Tor NoVNC
<br/>
<div align="center">
  <a href="https://mullvad.net">
    <img src="https://upload.wikimedia.org/wikipedia/commons/c/c9/Tor_Browser_icon.svg" alt="Logo" width="150" height="150">
  </a>
  <h1 align= "center">Tor </h1>
    <br/>
<p center "left">Tor(The Onion Routing) is a free overlay network for enabling anonymous communication.</p>
</div>

### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Tor NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/tornovnc.sh | bash
```
### Run Tor Xpra using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/torxpra.sh | bash
```
### Have Mullvad automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit mullvad service "USER" variable, USER variable is on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/torservice /etc/init.d/tornovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/tornovnc
```
### Step 5: After doing Step 1, 2, 3, and Step 4 run this command to have Waterfox NoVNC automatically start on boot
```
sudo service tornovnc start
```
## Have tor service automatically start on login
### First create the file using cat here document
```
sudo cat << EOF > /etc/profile.d/tor
sudo service tornovnc start 
EOF
```
### then create the waterfox service bash file in order for it work

## What Tor looks like
![2025-01-18_23-55.png](<https://media-hosting.imagekit.io//206f87de1060478c/2025-01-18_23-55.png?Expires=1831853600&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=pfMjz~U6WCGc90YOtLa~dJXAQOKBajb0p9eILcBua2jIvkJXbpKWgHLsSLMUTiXAVCI9rZQgLXfjwlcVdIhk-OguanrHCcKg2eejPQSLAZV7A4cLJRliuhn7IKKVqAZaDEfBVuAAffVTPAshLXhYq-GAI-0z4OiL-zpbEUQXoiBSwjEj~1RoHIcPwY4sLPI5K89Gkm3jHtmhUWMaIKAI2s7um5h~x4qKOA58Ip~9KosMV7pnCO~s9GRBWWXB2lKX0D7TwLRDKHkEY4utBsEY9fmzW1IxgrtUHisYDmwW2qvMlDqarpjNMmuyIdX2buwnIaEMlWwr0obcqfJskKY5EQ__>)
# Pale Moon NoVNC

<br/>
<div align="center">
  <a href="https://palemoon.org">
    <img src="https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/Pale_Moon_browser_icon.png/120px-Pale_Moon_browser_icon.png" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Pale Moon </h3>

  <p align="center">Pale Moon is a free, open-source browser focused on customization and privacy, based on an older version of Firefox.</p>
       
   <br/>
</div>

## Run Pale Moon NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Pale Moon NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/palemoonnovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit pale moon service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/palemoonservice /etc/init.d/palemoonnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/palemoonnovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/palemoon
#!/bin/bash
sudo service palemoonnovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/palemoon /etc/profile.d
```
## What Pale Moon looks like
![](screenshots/palemoon.png)
# Pulse NoVNC
<br/>
<div align="center">
  <a href="https://pulsebrowser.app">
    <img src="https://raw.githubusercontent.com/pulse-browser/assets/main/pulse-logo.png" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Pulse browser </h3>

  <p align="center">Pulse Browser is an experimental fork of Firefox designed to enhance productivity with a minimalistic user interface and built-in tools, such as a QR code generator and ad blocker. It aims to balance usability and privacy, offering features that differ from standard Firefox while still maintaining some level of security.</p>
       
   <br/>
</div>

## Run Pulse Browser NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Pulse Browser NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/pulsenovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit pulse service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/pulseservice /etc/init.d/pulsenovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/pulsenovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/pulse
#!/bin/bash
sudo service pulsenovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~ /pulse /etc/profile.d
```
## What Pulse Browser looks like
![pulse.png](<https://media-hosting.imagekit.io//16a84285d19b49a7/pulse.png?Expires=1832102775&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=ezjTfiJVDcVL7I9U-rsitCo39rMKjJz653Y5sxaQnDVXsAT5akHIQeVWNOQSa668g-EX0rcaZD8KpJlZPXaYGdNIRv-oHX2rtN0yVyjFxx1kuP~hz~nu77BDWL2UrEqylmPjOBP9ldCZyy~hQdPALLYQAJO2J5vPNmPuWak4K18cXThBLWJq6fOz7Jqor5FesuMtZHu37EaqsFsH4P8K0tjYc-JCVzecS3RxBk0JhZpsDCzcVF-ZaADXzK728Re0Sh2JHhvqdjlWBY6CPVwbVFjpXw0l7~88eczQEiOFG93L4RK70zm1NRRSouwrcOy7YEkZe74rADSwDb9joOun2w__>)
# Vivaldi NoVNC
<br/>
<div align="center">
  <a href="https://vivaldi.com">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Vivaldi_web_browser_logo.svg/456px-Vivaldi_web_browser_logo.svg.png?20190912145229" alt="Logo" width="130" height="130">
  </a>
  <h1 align= "center">Vivaldi</h1>
    <br/>
<p center "left">Vivaldi is a free, customizable web browser developed by Vivaldi Technologies, known for its built-in email client and features like ad blocking and privacy protection. It is designed for users who prefer a highly personalized browsing experience.</p>
</div>

## Run Vivaldi NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Vivaldi NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/vivaldinovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit vivaldi service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/vivaldiservice /etc/init.d/vivaldinovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/vivaldinovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/vivaldi
#!/bin/bash
sudo service vivaldinovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/vivaldi /etc/profile.d
```
## What Vivaldi looks like
![vivaldi.png](<https://media-hosting.imagekit.io//2b0ec0f9c002468f/vivaldi.png?Expires=1831853692&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=PJUB~C0F8KmrW5QwB6AI0e751GkQGMtSWajkyb1ajF4WRrjpqj~mzcjPzpFAE0kfj9xXvsuHkX9vcGkA6YtyroNVlEBubK1J9TJW3T4XunWqABZq-~~QyTOlR-rmK2dBiI3xa8gJnPRH6nYN3LAyzJbhy0fDcZgrw2n8rsW3CB810AvZQUHIt0x7I6LKzTug3vtZxMAfKuhgC1yGVaRkLA3y4-QwtSoIbVPKkkF4C~aEBp6CM~mEZwJcoK9Xt1c671jspDC-VHgz9QUKa7pGqB3VVstG5S52jv5uAsFJKzbUx3uaALJwvPw1wjFL2-tYaYj6euTSRZh7HjSThE~ZBw__>)
[Back to the top](#Table-of-Contents)
# Qutebrowser NoVNC

<br/>
<div align="center">
  <a href="https://palemoon.org">
    <img src="https://www.logo.wine/a/logo/Qutebrowser/Qutebrowser-Logo.wine.svg" alt="Logo" width="150" height="150">
  </a>

  <h3 align="center">Qutebrowser </h3>

  <p align="center">qutebrowser is a free, open-source web browser that is keyboard-focused and minimal in design.</p>
       
   <br/>
</div>

## Run Qutebrowser NoVNC
### Install curl if you don't have it
``` 
sudo apt install curl
```
### Run Qutebrowser NoVNC using Curl
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/qutebrowsernovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit qute service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/icecatservice /etc/init.d/qutenovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/qutenovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/qutebrowser
#!/bin/bash
sudo service qutebrowsernovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/qutebrowser /etc/profile.d
```
## What Qutebrowsers looks like
![](screenshots/qutebrowser.png)
# Zen NoVNC
<br/>
<div align="center">
  <a href="https://github.com/zen/zen-desktop">
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/3c/Zen_Browser_logo_%28red_circles%29.svg" alt="Logo" width="130" height="130">
  </a>
  <h1 align= "center">Zen</h1>
    <br/>
<p center "left">Zen Browser is a free and open-source fork of Mozilla Firefox, with its main focus being privacy, customizability and design </p>
</div>

## Run Zen NoVNC
## Install Curl if you don't have it 
```
sudo apt install curl
```
## Start Zen NoVNC
```
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/zenbrowsernovnc.sh | bash
```
### Have Icecat automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit zen service "USER" variable on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> 
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
#### Example of what USER variable looks like in the script
The number "13" below is to show what is on line 13
```
13 export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/zenservice /etc/init.d/zennovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/zennovnc
```
### create the file in /etc/proflie.d
```
cat << EOF >~/zen
#!/bin/bash
sudo service zennovnc start
EOF
```
### move the file to /etc/profile.d
```
sudo mv -f ~/zen /etc/profile.d
```
# What Zen Browser looks like
![](screenshots/zen.png)
[Back to the top](#Table-of-Contents)

# Similar Projects Im making
[LinuxApps NoVNC](https://github.com/gitxpresso/linuxapps-novnc)
As much linux apps I can find, any collaboration would help, thanks
Not going to work on this project until I have all the still working Browsers that support linux
# Set Default x www browser
#
