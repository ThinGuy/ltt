FROM uno:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt 2>/dev/null install -yqq toilet-fonts toilet wget

RUN wget -qO- ftp://ftp.figlet.org/pub/figlet/fonts/contributed.tar.gz|tar xzf - --strip 1 -C /usr/share/figlet

ENTRYPOINT GREETING=${GREETING:-Hello} NAME=${NAME:-World} TCOLS=${TCOLS:-80} && printf "\e[$(((${TCOLS}-(${#GREETING}+${#NAME}))/2))G${GREETING} ${NAME}"|toilet -W -w ${TCOLS} ${STYLE} ${FONT} 
