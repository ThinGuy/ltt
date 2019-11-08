FROM ubuntu:18.04

ENV container docker

RUN DEBIAN_FRONTEND=noninteractive apt 2>/dev/null -qq update && \
	DEBIAN_FRONTEND=noninteractive apt 2>/dev/null -yqq dist-upgrade && \
	DEBIAN_FRONTEND=noninteractive apt 2>/dev/null install -yqq figlet toilet-fonts toilet wget

RUN wget -qO- ftp://ftp.figlet.org/pub/figlet/fonts/contributed.tar.gz|tar xzf - --strip 1 -C /usr/share/figlet

ENTRYPOINT printf "\e[$((($(tput cols)-(${#GREETING}+${#NAME}))/2))G${GREETING} ${NAME}"|toilet -W -w ${TCOLS} --gay 
