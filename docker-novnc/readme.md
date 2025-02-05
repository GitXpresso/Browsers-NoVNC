### I've tested this gist with this setup:

- Odroid N2
- Armbian 24.2.1 Jammy CLI
- Ubuntu Desktop

### Useful links:
- Useful (but old) doc for VirtualGL with TurboVNC: https://virtualgl.org/vgldoc/2_1_1/#hd003001
    - VirtualGL complete guide: https://rawcdn.githack.com/VirtualGL/virtualgl/main/doc/index.html
    - How to install VirtualGL using APT: https://virtualgl.org/Downloads/YUM
    - How to install libjpeg using APT: https://libjpeg-turbo.org/Downloads/YUM
- Documentation? https://rawcdn.githack.com/TurboVNC/turbovnc/main/doc/index.html#hd005001
- Compatibility list: https://turbovnc.org/Documentation/Compatibility30
- Available configurations: https://github.com/TurboVNC/turbovnc/blob/main/unix/turbovncserver.conf.in


### The workflow:
1. Go to https://turbovnc.org/Downloads/YUM and follow the instructions in the APT section to install TurboVNC:
    - Prepare to install TurboVNC (run as root): 
        ```bash
        wget -q -O- "https://packagecloud.io/dcommander/turbovnc/gpgkey" | gpg --dearmor > "/etc/apt/trusted.gpg.d/TurboVNC.gpg"
        wget -q -O "/etc/apt/sources.list.d/TurboVNC.list" "https://raw.githubusercontent.com/TurboVNC/repo/main/TurboVNC.list"
        ```
    - **Optional** if you need OpenGL (run as root):
        - Prepare to install libjpeg:
            ```bash
            wget -q -O- https://packagecloud.io/dcommander/libjpeg-turbo/gpgkey | gpg --dearmor >/etc/apt/trusted.gpg.d/libjpeg-turbo.gpg
            wget -q -O "/etc/apt/sources.list.d/libjpeg-turbo.list" "https://raw.githubusercontent.com/libjpeg-turbo/repo/main/libjpeg-turbo.list"
            ```
        - Prepare to install VirtualGL (run as root):
            ```bash
            wget -q -O- https://packagecloud.io/dcommander/virtualgl/gpgkey | gpg --dearmor >/etc/apt/trusted.gpg.d/VirtualGL.gpg
            wget -q -O "/etc/apt/sources.list.d/VirtualGL.list" "https://raw.githubusercontent.com/VirtualGL/repo/main/VirtualGL.list"
            ```
    - Install TurboVNC:
        ```bash
        sudo apt update
        sudo apt install -y turbovnc
        ```
    - Install TurboVNC **and** VirtualGL:
        ```bash
        sudo apt update
        sudo apt install -y turbovnc virtualgl libjpeg-turbo-official
        ```
3. [*EXPERIMENTAL*]
    - Run `sudo vim /etc/X11/xorg.conf.d/10-vnc.conf` and insert:

          Section "Module"
          Load "vnc"
          EndSection
 
          Section "Screen"
          Identifier "Screen0"
          Option "UserPasswdVerifier" "VncAuth"
          Option "PasswordFile" "<home_path>/.vnc/passwd"
          EndSection

    - Change `<home_path>` with your own home path
    - This section is experimental and needs verification
3. Create the password for the user:

        $ /opt/TurboVNC/bin/vncpasswd

4. Start a server the first time, as user:

        $ /opt/TurboVNC/bin/vncserver

    - An instance on screen :1 should start without problem
5. Kill the newly created server:

        $ /opt/TurboVNC/bin/vncserver -kill :1

6. Setup the server to start at boot:
    - Modify `/etc/sysconfig/tvncservers`:

            $ sudo vim /etc/sysconfig/tvncservers

      Uncomment the last two lines (or just the VNCSERVERS and manage the configurations in `~/.vnc/turbovncserver.conf`):

            VNCSERVERS="1:<username>"
            VNCSERVERARGS[1]="-geometry 1920x1080"

      Change `<username>` with your own and change the args as preferred
    - Reboot and start the systemd service and enable it:

            $ sudo systemctl start tvncserver
            $ sudo systemctl enable tvncserver

    - Check if the service started correctly:

            $ sudo systemctl status tvncserver

7. Desktop environment can be set, with other parameters, insdie `~/.vnc/turbovncserver.conf`

            $wm = plasma
            $geometry = 1920x1080

    - The value of `$wm` can be found in `/usr/share/xsessions`, it's the name of the file without `.desktop`; in the case of the KDE Plasma DE, the file found is `plasma.desktop`