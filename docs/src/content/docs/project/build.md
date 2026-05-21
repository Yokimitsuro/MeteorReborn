---
title: Setting up the build
description: FFXIV 1.0 reference for Meteor Reborn.
---

*Updated as of commit 18ef69f (2019-06-19)*  

### **NOTICE**

 

This is for setting up a server for the **FINAL FANTASY XIV v1.23b** client, the original iteration of the game. 

The **FINAL FANTASY XIV: A REALM REBORN** client is **not** compatible with this project. 

 

### Introduction

  Final Fantasy XIV 1.0, like most large scale MMO's, consists of multiple servers working in unison to manage connected clients and their interactions with the game world. 

#### Server Layout

  A working install of Project Meteor Server installation consists of the following: 1. **Login Server:** A web server that manages user accounts and the login process for the game client 2. **Database Server:** Contains the user accounts, their characters, and game assets (such as item and NPC information) 3. **Lobby Server:** Manages the characters associated with each user account, and their connection states, also tracks the status of the game servers 4. **Game Servers:** Game Server instances (one instance per world) that tracks the player state and interacts with the client as the user plays the game  

  Official game server layout   

- 
- 
- 
- 

- 
- 
- 
- 

|  |
|---|
| 1. World 1 Game Server     Region 1-A Game Server    Region 1-B Game Server    ...  Region 1-N Game Server 2. World 2 Game Server   Region 2-A Game Server  Region 2-B Game Server  ...  Region 2-N Game Server 3. World 3 Game Server  ...  N. World N Game Server |

   While there can be multiple game servers to represent multiple worlds, there are only a single Login/Lobby/Database server per site. The servers do not require that they are all installed on the same machine, only that they can communicate with each other, either though the local network, or though the internet. A small installation might consist of all 4 servers being hosted on the same machine as the client, whereas a large install might have each individual server hosted on separate OS/machine instances.   Unlike the official/retail servers, currently there can only be a single game server instance per world. Future plans are to optionally break up the game server to be per region, instead of one game server per world, similar to how the official servers run. 

#### Running and installing Project Meteor Server

  Unlike the game client, which mainly consists of installing, launching, and optionally patching the game as needed, setting up a working Project Meteor Server site requires the ability to install multiple pieces of software and configuring them so that the servers can communicate with each other.  A person interested in setting up their own Project Meteor Server site must be able to do the following: 
1.  Have the ability to install software on one or more machines, and following the instructions on how to do so 
2.  Understand how to find their IP and what an IP is 
3.  Understand the basic concepts what GIT is and compiling software (actual ability to code is not required) 
4.  Able to read and understand tables of data/database entries (extensive SQL knowledge is not required)
  

### Requirements

 

#### Running the Server

 

        
| Name | Support Level |
|---|---|
| Windows 10 | Officially Supported |
| Windows 8.1 | Works/Unsupported |
| Windows 7 | Works/Unsupported |
| Windows Server 2016 | Works/Unsupported |
| Windows 8 | Should work/Untested |
| Windows Vista | Unsupported |
| Windows XP (or older) | Unsupported |

 

 

 

   
| Name | Support Level |
|---|---|
| Apache 2.4 (or newer) | Officially supported |
| nginx 1.10 (or newer) | Works/Unsupported |

 

   
| Name | Support Level |
|---|---|
| MySQL 5.7 (or newer) | Officially supported |
| MariaDB 10.3 | Officially supported |

 

  
| Name | Support Level |
|---|---|
| PHP 7 (or newer) | Officially supported |

 

 

  

#### Running the client

 

   [](20250716233815/http://seventhumbral.org/downloads.php)[](20250716233815/http://seventhumbral.org/downloads/launcher/sumlauncher-1.03.exe)
| Name | Version |
|---|---|
| Final Fantasy XIV 1.23b | 2012.09.19.0001 |
| Seventh Umbral Launcher | 1.03 |

  

**Note:** The Seventh Umbral Launcher can patch any existing client install to the latest version 

  

#### Optional Downloads/Quick-setup

 
-  [WAMP All in one installer](20250716233815/http://www.wampserver.com/en/#download-wrapper): Quick-setup installer that includes the following: 
 

 ************
|  |  |  |
|---|---|---|
| Apache | MySQL | PHP |

 
-  [HeidiSQL](20250716233815/http://www.heidisql.com/): A SQL manager/GUI 
-  [SourceTree](20250716233815/https://www.sourcetreeapp.com/): A git client
 

### Compiling from source

 

#### Compiler Requirements

 

  
  
 
| Name | Support Level | Notes |
|---|---|---|
| Visual Studio 2017 | Officially supported | Users will need to manually select the NuGet and  .Net 4.5 modules when installing. |
| Visual Studio 2015 | Officially supported |  |
| Visual Studio 2013 | Works/Unsupported | Users may need to install a modern compiler via NuGet, or will receive errors from the source. |
| Visual Studio 2012 (or older) | Unsupported |  |

 

 

 

   
| Name | Version |
|---|---|
| NuGet 3.4 (or newer) | Officially supported |
| NET Framework 4.5 | Officially supported |

  

#### Compiling

 

##### Getting the Source Code

  

###### Via Sourcetree

 1. Download and install SourceTree  2. [sourcetree://cloneRepo/[https://bitbucket.org/Ioncannon/project-meteor-server.git](20250716233815/https://bitbucket.org/Ioncannon/project-meteor-server.git) Clone in Sourcetree] 3. Select folder to clone source code to 

###### Manually via Bitbucket

 1. Go to the [Server source code](20250716233815/https://bitbucket.org/Ioncannon/project-meteor-server) 2. Click the "Downloads" button on the sidebar 3. Click "Download Repository" 4. Extract to desired folder  

##### Building

 1. Set up your compile environment/IDE to support compiling NET 4.5 2. Open **Meteor.sln** from where the source code was copied to in the previous steps 3. Get the dependencies via NuGet Select the **Solution Explorer** Tab Right Click **Solution 'Meteor' (4 Projects)** Select **Restore NuGet Packages** 4. Select *Debug*/*Release* (as desired) 5. Go to the **Build** Menu and select **Build Solution**  **Note:** You do not need to do this step until you have finished configuring your server below 6. If everything compiled correctly, the output log should look like: 

` ========== Build: 4 succeeded, 0 failed, 0 up-to-date, 0 skipped ========== ` 

 

### Server Setup

 

#### Setting up with WAMP

 

##### Installing WAMP

 1. Download and install WAMP 2. Start the server by clicking on the **WampServer64** icon created by the installer 3. Verify all services are properly started by checking on the **W** Icon in the notification bar: 
-  Green: All services started properly 
-  Yellow: Some services started properly 
-  Red: All services have stopped
 

**Note:** Start/restart/stop the WAMP server by clicking on the **W** icon and selecting Start/Stop/Restart All Services 

 

 

##### Setting Up the Database

 1. Confirm all WAMP services are installed 2. Left Click the WAMP status icon 3. Open **MySQL** → **my.ini** 4. Find the line containing `sql-mode="STRICT_ALL_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ZERO_DATE,NO_ZERO_IN_DATE,NO_AUTO_CREATE_USER"` and change it to `sql-mode="NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"` 5. Restart the MySQL service (if not already started) by left clicking the WAMP status icon and selecting **MySQL** → **Service Administration** → **Restart Service** 6. Download, install, and run HeidiSQL 7. Select the **New** button to create a new connection and select **Open**  **Note:** If the SQL server IP/username/password differ from the defaults, change them here, otherwise continue to the next step 8. Verify you are connected:  A newly set up/blank mysql server should have the following databases listed: 

 
|  |  |  |  |
|---|---|---|---|
| information_schema | mysql | performance_schema | sys |

 9. Right Click **Unnamed** and go to **Create new** → **Database** and name the new database: **ffxiv_server**  **Note:** If you changed the name of the server in step 3, the name will be that instead of **Unnamed** 10. Click the new **ffxiv_server** database entry 11. Go to **File** → **Run SQL File** and navigate to the **<Project Meteor Server source code location>\data\sql\** folder 12. Select all SQL files in the folder, and execute them.  **Note:** HeidiSQL may warn you about mixed linebreaks, or an empty warning prompt after executing the query. Ignore them, it'll still run the query successfully. 

##### Setting Up the Login Server

 1. Confirm all WAMP services are running 2. Navigate to the location of the server source code 3. Copy all of the **data/www/login_su** folder contents from the source code folder to the WAMP install location  The default location is: **C:\wamp64\www** 4. **OPTIONAL:** If you have modified the database login settings, change them at:  **<web server www folder>\config.php** 5. Restart the WAMP services 

##### Compiling Lobby and Game Server

 1. Navigate to the location the game client has been installed to and copy the following file:  **<FINAL FANTASY XIV client install location>\client\script\rq9q1797qvs.san** 2. Navigate to the location of the server source code and rename **rq9q1797qvs.san** to:  **<Project Meteor Server source location>\data\staticactors.bin** 3. **OPTIONAL:** If the server and client are on different machines, edit the server IPs in the following locations: 
-  **<Project Meteor Server source location>\data\config.ini** 
-  **<SQL database>\ffxiv_server\servers**
 4. Compile the server (See #Compiling)  **Note:** If you had compiled it before this, use **Rebuild Solution** instead of **Build Solution** to confirm that all the data files are copied properly 

##### Setting up Lobby, World and Map Servers

 
1.  **OPTIONAL:** If the server and client are on different machines, edit the server IPs in the following locations **<Project Meteor Server source location>\data\(lobby/map/world)_config.ini** **<SQL database>\ffxiv_server\servers** **<SQL database>\ffxiv_server\server_zones** *if the map servers are not on the same server as world server 

 
2.  Copy **lobby_config.ini** from **<Project Meteor Server source location>/data/** 
  to **<Project Meteor Server source location>\Lobby Server\bin\(Debug\Release)\** 
 
3.  Copy **map_config.ini**, **staticactors.bin** and the **scripts** folder from **<Project Meteor Server source location>/data/**  to **<Project Meteor Server source location>\Map Server\bin\(Debug\Release)\** 
 
4.  Copy world**_config.ini** from **<Project Meteor Server source location>/data/** 
  to **<Project Meteor Server source location>\World Server\bin\(Debug\Release)\**
 

Do not skip step 3 for the love of our sanity. 

 

#### Installing Manually

  

##### Requirements

 1. Install and start desired web server 2. Install and start desired PHP processor 3. Install and start desired SQL engine 

##### Database

 1. Create a database named **ffxiv_server** 2. Confirm that the sql server is set with the following behavioral defaults: 

```
sql-mode="NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
```

 3. Load the SQL files of **<Project Meteor Server source code location>\data\sql\** into the database 

##### Login Server

 1. Copy the following to web server: **<Project Meteor Server source location>\data\www** 2. **OPTIONAL:** If you have modified the database login settings, change them at:  **<web server www folder>\config.php** 3. Restart the web server service 4. Navigate to **http://<web server ip>/create_user.php** and create a new account 

 

 

##### Compiling Lobby and Game Server

 1. Navigate to the location the game client has been installed to and copy the following file:  **<FINAL FANTASY XIV client install location>\client\script\rq9q1797qvs.san** 2. Navigate to the location of the server source code and rename **rq9q1797qvs.san** to:  **<Project Meteor Server source location>\data\staticactors.bin** 3. **OPTIONAL:** You can configure the IP address, port, database name, and database password for both the lobby server and map server under: 
-  **<Project Meteor Server source location>\data\**
 4. Compile the server (See #Compiling)  **Note:** If you had compiled it before this, use **Rebuild Solution** instead of **Build Solution** to confirm that all the data files are copied properly  

##### Setting up Lobby, World and Map Servers

 
1.  **OPTIONAL:** If the server and client are on different machines, edit the server IPs in the following locations **<Project Meteor Server source location>\data\(lobby/map/world)_config.ini** **<SQL database>\ffxiv_server\servers** **<SQL database>\ffxiv_server\server_zones** *if the map servers are not on the same server as world server 
2.  Copy **lobby_config.ini** from **<Project Meteor Server source location>/data/**  to **<Project Meteor Server source location>\Lobby Server\bin\(Debug\Release)\** 
3.  Copy **map_config.ini**, **staticactors.bin** and the **scripts** folder from **<Project Meteor Server source location>/data/**  to **<Project Meteor Server source location>\Map Server\bin\(Debug\Release)\** 
4.  Copy world**_config.ini** from **<Project Meteor Server source location>/data/**  to **<Project Meteor Server source location>\World Server\bin\(Debug\Release)\**
 

#### Starting the servers

  1. Confirm all WAMP/web services are running  2. Run the lobby server: **<Project Meteor Server source location>\Lobby Server\bin\(Debug\Release)\Lobby Server.exe**  3. Run the map server: **<Project Meteor Server source location>\Map Server\bin\(Debug\Release)\Map Server.exe**  4. Run the map server: **<Project Meteor Server source location>\World Server\bin\(Debug\Release)\World Server.exe** 

### Client Setup

 

#### Configuring the client

 1. Install the Final Fantasy XIV client 2. Install the Seventh Umbral launcher 3. Open **<Seventh Umbral launcher install location>\servers.xml** 4. Create a new entry: 

```
<Server Name="Localhost" Address="127.0.0.1" LoginUrl="http://localhost/login.php" />
```

  **Note:** If the server is on a different machine then the client, change **Address** and **LoginUrl** to reflect that 5. Run **<Seventh Umbral launcher install location>\Launcher.exe** 6. Go to **Game Settings** and enter the path to **<FINAL FANTASY XIV client install location>** 7. Restart the launcher and patch client if necessary 8. [Make an account](20250716233815/http://localhost/create_user.php) 

```
http://localhost/create_user.php
```

  **Note:** If the server is on a different machine, use it's IP instead of localhost 

#### Starting the client

 1. Run **<Seventh Umbral launcher install location>\Launcher.exe** 2. Select the correct server from the **Server** dropdown box 3. Log in with previously created account
