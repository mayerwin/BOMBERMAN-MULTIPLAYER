# BOMBERMAN-MULTIPLAYER

Play **Atomic Bomberman (1997)** over LAN using IPXBox and IPXWrapper.  
This repository contains helper scripts and configuration files to make setup easier.

---

## 🚀 Installation

1. **Install Atomic Bomberman**  
   - Use the original CD or an ISO image (example: [archive.org link](https://archive.org/details/Nova_AtomicBombermanUSA)).  

2. **Download this repository (includes IPXWrapper and IPXBox)**  
   - Click the green **Code** button → **Download ZIP**.  
   - Copy all the files from the `.zip` into your Bomberman install directory (overwriting existing files).

3. **(Optional) Update to the latest version of IPXWrapper**  
   - Get the latest release from here:  
     [IPXWrapper releases](https://github.com/solemnwarning/ipxwrapper/releases)  
     (At the time of writing: `ipxwrapper-0.7.2.zip`).
   - Copy all the files from the `.zip` into your Bomberman install directory (overwriting existing files).

4. **(Optional) Update to the latest version of IPXBox**  
   - Follow the instructions to compile IPXBox from source here:
     [IPXBox How-To](https://github.com/fragglet/ipxbox/blob/trunk/HOWTO.md) 
   - Copy the ipxbox.exe file into your Bomberman install directory (overwriting existing files).

5. **(Optional) Change your computer name**  
   - Open `nodename.ini`.  
   - Replace `"TNT"` with your preferred name.  
   - Avoid spaces or special characters.  
   - This name will appear in LAN games.

---

## 🎮 Each Time You Want to Play on LAN
An IPX server (like IPXBox) is not strictly necessary, as IPXWrapper makes it possible for computers to communicate to each other directly without a central server, but without one the game unfortunately [lags](https://github.com/solemnwarning/ipxwrapper/issues/14).

1. **Start the IPX server (host computer only)**  
   - Run `start-ipxbox-server.bat`.  
   - A pop-up will display the **IP address of the server**.  
   - Share this address with other players.

2. **Set the server address (on each client computer)**  
   - Open `ipxwrapper.ini`.  
   - Find the line:  
     ```
     dosbox server address = 127.0.0.1
     ```  
   - Replace `127.0.0.1` with the **IP address from the host**.

3. **Start the game**  
   - Run `start-bomberman.bat`.

4. **Choose the network option**  
   - In the game, select **IPX** as the network mode to play multiplayer.

---

✅ That’s it! You’re ready to enjoy **Atomic Bomberman** with your friends over LAN.  
💣 Have fun blowing each other up!
