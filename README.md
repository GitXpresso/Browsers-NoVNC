# Browsers-NoVNC
Every browser that supports linux and has no errors with the browser in the novnc session and `--display=:0` works with installed browser in the terminal will be added to this repository
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

- [ ] add link to video pn how to have waterfox noVNC automatically start on bootboo
- [ ] finish adding all service files 
- [ ] use winehq to install browsers that dont work 
- [ ] use winehq to have opera gx in a browser
- [ ] Contact "thelamer" to see if he he can make a linuxserver kasmvnc docker container for the following browsers
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

<details><summary>Mozilla Browsers</summary>
  
- [Firefox NoVNC](#Firefox-NoVNC)
- [Seamonkey NoVNC](#Seamonkey-NoVNC) 

</details>

<details><summary>Firefox Based Browsers</summary>
  
- [Librewolf-NoVNC](#Librewolf-NoVNC) 
- [Floorp NoVNC](#Floorp-NoVNC)
- [Tor NoVNC](#Tor-NoVNC) 
- [Mullvad NoVNC](#Mullvad-NoVNC) 
- [Waterfox NoVNC](#Waterfox-NoVNC)
- [Icecat NoVNC](#Icecat-NoVNC)
- [Zen Novnc](#Zen-NoVNC)
- [Pale Moon NoVNC](#Pale-Moon-NoVNC)
- [Midori NoVNC](#Midori-NoVNC)
- [Pulse NoVNC](#Pulse-NoVNC) 
</details>

<details><summary>Other</summary>
  
- [Similar Projects I making](#Similar-Projects-Im-making)

</details>

- [Qutebrowser NoVNC](#Qutebrowser-NoVNC) 
- [Falkon NoVNC](#Falkon-NoVNC) 
- [Chrome Novnc](#Chrome-NoVNC) 
- [Vivaldi NoVNC](#Vivaldi-NoVNC)

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
## What Chrome looks like
![Google Chrome](<https://media-hosting.imagekit.io//b17cc3fbdfae406e/Screenshot%202025-01-17%2011.56.23%20AM.png?Expires=1831741275&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=lAbs2zDf39IWAKpSYw9vIQkF7RlXwJ83A9gYaX0clmEehdTLz1MdZgYcIkrlwFBK6BvBvXCw6hrYz-7YcYdedOGgd2LaWgB-1DgWesQ16LTiv7-xijYVeWe2PvSjCjvhHsEWs-H00lJPGcyN-Jwpv5lVHCr9dmCgFIMLUGxfUAlHUh~hZCFQB4pkCCA7YWlLsNXg3skE8zba2ypK2wy8Oz~yuxf9-DUcp0ae3Vc3zWePcLd6RjZn1FcbyU~8DLlEsbg3rOJj1orUN7Pv-CuOHcEdf-69FxTHLcWTej~yyZEJrxY6W1p8wmgXFcxvRauILJ109s-1eVD1Dm9r6~R4sg__>)
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
## What Falkon looks like
![falkon.png](<https://media-hosting.imagekit.io//032559a8ffc848cf/falkon.png?Expires=1831928501&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=C3dpIdsOwRWSWbODi4DdeGNaAm-zA8RGxrymqNpEFPUr~2pL4mtCDOeGryJG24EApXQ0YnGPu2zkgSBARvUW5qWyGTs3DLtTyIlsQ5FjMxQdN8OJMpfalZWiihzYnSMwoVUxj85Ylo8ps8fYEvhIzSTq1dU~Mfn~U9~Rg8xAWD0LYbqwpr0~az4b5ZzSb9d0Ex4QXkjH-RGJ4UdAxe~icC3Dlrii0-a799mzeBxO-9-VF1RKSaM29PiHx1SWborhh7lU0GnivmBwxouC09Mk8u4ToJYgbdATdRwrrW6xdfLD0fiUpdDK~gUEUyDCXj9X35ey9AIEQE-G-GUAvKu7dA__>)
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
## What Firefox looks like
![Screenshot 2025-01-17 12.44.44 PM.png](<https://media-hosting.imagekit.io//ac2aeff7e77e4d15/Screenshot%202025-01-17%2012.44.44%20PM.png?Expires=1831743897&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=nAuc~o8OcMQZ-Mw5zef17L9m5QBbmdqt6Z~OqYqVrEyNtaqg4OKCpAqMcCN7q08En2h80CqF2lvjQFlCmCobesHpCqwDZ-qsYsTFHwZrYsnzHhnVv-9q0I~aVkX1OoA4JgnfQ~dBlvwwp5faO67RAzi~UtMdYsMolaOEqdz-wfQ2WuMx0VbgFEmT~G3jvhCsrO7BFDYuqmKhLiH-Gfuy7tF3DMQ0TKssy8JlDld0I9bUNzvj-s9H6copbraSoquqXLIjHv7AphCD0UdhOF0XW6QHI3Wwy6aVBqkBmKpJI7G3UcWdHKcOuoQt-iWo~h29OvsOHsgtEvgQsbwNdyRL3g__>)
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
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
example:
```
export USER="linux"
```
### Step 3: After setting the user variable in Step 2 run the command below in your bash terminal
```
sudo mv -f ~/browsers-novnc/waterfoxservice /etc/init.d/waterfoxnovnc
```
### Step 4: Make the file executable
```
sudo chmod +x /etc/init.d/waterfoxnovnc
```
### Step 5: After doing Step 1, 2, 3, and Step 4 run this command to have Waterfox NoVNC automatically start on boot
```
sudo service waterfoxnovnc start
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
### What Midori looks like
![Screenshot 2025-01-21 1.12.54 PM.png](<https://media-hosting.imagekit.io//286624c5827443c2/Screenshot%202025-01-21%201.12.54%20PM.png?Expires=1832091360&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=R~adlf4glr451sMC7XmycRmzj3DAqcsaoRyljoYxjjjoFxXl8sI1aEXTL~2J5IGc0Qh8XZHUPKd509zVQgbgpKIoI2timZjw1UiG50ePn8HkN7qqySaqmvYR0MbjyvMBg4EqtPj9LxBSk2sERKzz9eTYBBoHSYQtaDHc9CsjnSCH8Ad31~Zk-Zu--f3zyoAoajIeYR1fUWYqVS4A1qtHwka8Mx1zEOCjNLXKo0q73uRdOm0mfBho4~2nZsE9zXqNOrqw-Um7cc1XGSmVgjjGmzFBinAHN8rreIU9HadGmkpKWE7HCuNxrMfNT1C4uUQVUhvvQkg6obVs1ECJFVR64Q__>)

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
### Have Waterfox automatically starts on boot
### Step 1: Clone the repository
```
git clone https://github.com/gitxpresso/browsers-novnc.git ~/browsers-novnc
```
### Step 2: Go to the cloned directory and edit waterfox service "USER" variable, USER variable is on line 13
> [!TIP]
> If you don't know current your linux username then do "whoami" or "echo $USER" to find your current linux username
> You can edit the file using vim after finishing editing the file do `:wq` and press `ENTER` to save and exit
example:
```
export USER="linux"
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
## What Pale Moon looks like
![Screenshot 2025-01-21 10.41.31 AM.png](<https://media-hosting.imagekit.io//d4ecf443d1ae450f/Screenshot%202025-01-21%2010.41.31%20AM.png?Expires=1832082120&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=zGtdOO1NXevsvrqrGySJpGbf6FjpR3YeK4498zUe1QklD9BBfstzCyNzHbIB6-uNFaX6lkiRflgRtCcheY~w43zjvtxWfF5ajrXPS58XXskoZ0Cn0mek9ea-KMOLCkBHW-WPuorNy49nMlhwy53A3KalnPEZ60TaQ-zIRAFt1fYmncUZ5~9mbzq0c0kAJT0R8sUqcw~285U1DEXAfwJY80rCS9QGBPyglahwSzzyvchAb0qVxfNw6JD8X~p61JALouYqqDARO82v6-jW-BFUcCgSgI0jq-4ZR~n-reFjjHi2Qka4IHmclStHNeBaeK6oxJ152shkn7EvcP1XFYxUqw__>)
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
## What Qutebrowsers looks like
![Screenshot 2025-01-21 12.33.32 PM.png](<https://media-hosting.imagekit.io//a25233fc22b04390/Screenshot%202025-01-21%2012.33.32%20PM.png?Expires=1832088829&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=WTq6~YtNSGM4cufa4pjCg2eMR5tFaFMNBHpTgohOmdkvZ4EUXTrv9lmmZa1Sf4rKyM9NuV2EjE-bnJrwOktLTaUzpPuOrwr3witpDFZexCmo71po28C91et4j3DOo3NZQEK0HwytaIbXx4IFBg-HPruakrZzn1ooTWfqWea-b~fPwcIB~wBerpznFVJLNzVTGydOMFMv7VXk-dh9SwhW1O8CnWuJ1M6G71gYasOeIdxBAjhSkPQCbdFgG3j4Ps5P7eDOWcdc7ASuZCRtlhoS0zqb1MjYPsxuZaxI8el8HMa~6p314YNpnH2D~p9puWUzcKHyO5ltdtL06VXJ3TNHRw__>)
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
# What Zen Browser looks like
![Screenshot 2025-01-17 12.29.18 PM.png](<https://media-hosting.imagekit.io//67a2fb69d27e455f/Screenshot%202025-01-17%2012.29.18%20PM.png?Expires=1831742984&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=nSkvMo~KvfBTHo16JKUVLhDgSj-qK2~HOm-TX-jTfL9buABdxAgTukMbWKB4HwBjGFGe3vQZbfdTAFUMYEl--~C4mv9RDa1FlkOVvlxCcaaelVPRbc~mR7wdgVDqgm9TFLfBdc0ldLLAh1l-tjwAFDOSrelAuNm4u3bpeq0TGI5drM800rBBXK0rnnNkopdTxDQxGkZ9oM9RmWw7XuDKHYSnG97GOezx4chYRcPPL809WioNIeL8EtmGFodICInT7d~~~x6e7Oi-ViEDls-ETSlZ~vYbgMVbb4ijl0itXhtXRQ5Kvfp8Lno7JDe7Jr3k0SBYB9gszS~Rlcju0tkaCQ__>)

[Back to the top](#Table-of-Contents)

# Similar Projects Im making
[LinuxApps NoVNC](https://github.com/gitxpresso/linuxapps-novnc)
As much linux apps I can find, any collaboration would help, thanks
Not going to work on thos project until i have all the still working Browsers that support linux
