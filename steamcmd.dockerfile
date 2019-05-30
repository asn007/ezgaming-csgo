##################################################################
# Dockerfile that contains SteamCMD. Initial version by CM2Walki #
##################################################################
FROM debian:stretch-slim
LABEL maintainer="andrey@ezgaming.gg"

# Install, update & upgrade packages
# Create user for the server
# This also creates the home directory we later need
# Clean TMP, apt-get cache and other stuff to make the image smaller
# Create Directory for SteamCMD
# Download SteamCMD
# Extract and delete archive
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6 \
		lib32gcc1 \
		wget \
		ca-certificates && \
	apt-get clean autoclean && \
	apt-get autoremove -y && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN useradd -d /home/steam -m steam

RUN su steam -c \
		"mkdir -p /home/steam/steamcmd && \
		cd /home/steam/steamcmd && \
		wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -"

USER steam

VOLUME /home/steam/steamcmd
EXPOSE 27036/udp
