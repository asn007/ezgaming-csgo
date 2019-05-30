############################################
# Dockerfile that builds a CSGO Gameserver #
############################################

FROM asn007/steamcmd
LABEL maintainer="andrey@ezgaming.gg"

ENV SRCDS_FPSMAX=300
ENV SRCDS_TICKRATE=128
ENV SRCDS_MAXPLAYERS=11
ENV SRCDS_TOKEN=0
ENV SRCDS_RCONPW="changeme"
ENV SRCDS_PW="changeme"
ENV SRCDS_NAME="yolo"

RUN mkdir -p /home/steam/deploy

COPY ./deploy /home/steam/deploy
RUN chmod +x /home/steam/deploy/start_cs_server.sh

EXPOSE 27015 27015/udp 27005/udp 27020/udp 51840

VOLUME "/home/steam/csgo"
VOLUME "/home/steam/csgoconfig"



# Run Steamcmd and install CSGO
#RUN set -x \
#	&& ./home/steam/steamcmd/steamcmd.sh \
#		+login anonymous \
#		+force_install_dir /home/steam/csgo-dedicated \
#		+app_update 740 validate \
#		+quit \
#	&& { \
#		echo '@ShutdownOnFailedCommand 1'; \
#		echo '@NoPromptForPassword 1'; \
#   echo 'login anonymous'; \
#		echo 'force_install_dir /home/steam/csgo-dedicated/'; \
#		echo 'app_update 740'; \
#		echo 'quit'; \
#	} > /home/steam/csgo-dedicated/csgo_update.txt \
#	&& cd /home/steam/csgo-dedicated/csgo \ 
#    	&& wget -qO- https://raw.githubusercontent.com/CM2Walki/CSGO/master/etc/cfg.tar.gz | tar xf -

# install metamod
# install sourcemod
# install csay
# install ebot



#ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/csgo-dedicated +app_update 740 +quit && \
#		./home/steam/csgo-dedicated/srcds_run -game csgo -console -autoupdate -steam_dir /home/steam/steamcmd/ -steamcmd_script /home/steam/csgo-dedicated/csgo_update.txt -usercon +fps_max $SRCDS_FPSMAX -tickrate $SRCDS_TICKRATE -port $SRCDS_PORT -tv_port $SRCDS_TV_PORT -maxplayers_override $SRCDS_MAXPLAYERS +game_type 0 +game_mode 1 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount $SRCDS_TOKEN +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW +sv_region $SRCDS_REGION

#EXPOSE 27015 27020 27005 51840

ENTRYPOINT /home/steam/deploy/start_cs_server.sh
