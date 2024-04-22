This repository is created with a goal to keep Metal Gear Solid V: The Phantom Pain multiplayer alive after it gets shutdown someday.
It's basically a refactor of the original (abandoned) [MGO3 emulator](https://github.com/unknown321/mgsv_emulator) project and  [mxmstr's Nucleus co-op](https://github.com/mxmstr/mgsv_emulator) project, both of which I've disgracefully stolen from to create a version more accessible for ordinary human beings. You can host this version using the provided Python3 webserver, instead of the original authors' complicated setup with Apache 2 + mod_wsgi. I hope this version of the project contributes to easier and faster development of the emulator.

*The MGO3 emulator will function as is, but there's still a lot of work required to turn it into a fully-fledged emulator. This project needs clear documentation and a detailed plan outlining outstanding tasks, challenges to be solved, and so on. However, I've barely found the time to create the webserver and refactor the project, so I don't anticipate being able to contribute often. Also, to be completely honest, I'm not sure if I have the programming experience to complete this project on my own. So, if you're concerned about the game's future once they pull the plug - feel free to jump in and contribute. For this purpose I've created the MGO3 Sanctuary Discord server https://discord.gg/6uuF37PF43, which is a central hub for MGO3 emulator development. I plan to regularly moderate the server to ensure it remains a collaborative and welcoming space.*

# Installation
First, update the system and then install dependencies.
```
sudo apt update
sudo apt install git curl 
```
Clone the repository and set it as the current working directory.
```
git clone https://github.com/35mpded/mgo3-server-emulator.git && cd mgo3-server-emulator
```

Create a virtual environment for Python 3.10 and then activate it.
```
sudo apt install python3.10-venv
/usr/bin/python3 -m venv ./mgo3-py-venv
source mgo3-py-venv/bin/activate
```
Once inside the virtual environment, install Flask, Hypercorn, and PyMySQL.
```
pip install flask hypercorn pymysql
```

# Import the database:
Install and set up Percona using the following command.
When asked which encryption method you want to use, you can select either:
- "Use Strong Password Encryption (RECOMMENDED)
- "Use Legacy Authentication Method (Retain MySQL 5.X compatability)"

*Note that ./Database.py is configured to use the user "root" with the password "123". When prompted for password, use the password "123"; otherwise, if you change it, ensure to update this in the ./Database.py file and reflect the changes in the subsequent steps.*
```
curl -O https://repo.percona.com/apt/percona-release_latest.generic_all.deb && sudo apt install -y ./percona-release_latest.generic_all.deb && sudo percona-release setup ps80 && sudo apt-get install -y --allow-downgrades --no-install-recommends percona-server-test
```


After you installed Percona It's time to create the database.<br>
*Note that database name, user, and password must not be changed in the below commands. If you wish to change them, you need to reflect this change in the ./Database.py file.*
```
# Create the database
mysql -u root -p123 -e "CREATE DATABASE mgsv_server;"

# Import the database 
mysql -u root -p123 mgsv_server < ./db/mgsv_server.dump.sql
```

# Run the MGO3 emulator
After completing the necessary steps to configure and install the dependencies, it's now time to run the server. Please note the following.
- You need to change `127.0.0.1:80` to your private or public IP address unless you are planning to run the game client on the same machine as the emulator host. This change should also be made during the patching process of the MGO executable and in the `/mgo3-server-emulator/server/command/CMD_GET_URLLIST.py file`.
- You must run Hypercorn as sudo to allow it to bind to port 80, so ensure you do not deviate from the command provided below.
```
sudo ./mgo3-py-venv/bin/python -m hypercorn mgo3:app -b 127.0.0.1:80
```

# Patching the MGO executable
This section is a work in progress. When I have the time, I'll publish a GIF or a detailed guide on how to patch it.
