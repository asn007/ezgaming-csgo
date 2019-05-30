#!/bin/bash

# Step 1. Install & update CSGO

echo "Updating CS:GO..."
/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/csgo +app_update 740 validate +quit
echo "Installing appid..."
cp /deploy/steam_appid.txt /home/steam/csgo/steam_appid.txt /home/steam/csgo/steam_appid.txt
echo "Installing configs..."

mkdir -p /home/steam/.steam/sdk32/

cp /home/steam/bin/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

chown -R steam:steam /home/steam

echo "Preparing to launch CS:GO"
cd /home/steam/csgo

./srcds_run -game csgo -console -autoupdate -steam_dir /home/steam/steamcmd/ \
-usercon -port 27015 +clientport 27005 \
+tv_port 27020 -tickrate ${SRCDS_TICKRATE} \
+map de_dust2 +servercfgfile=/home/steam/csgoconfig/server.cfg \
+game_mode 1 +game_type 0 +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW +server_name $SRCDS_NAME


