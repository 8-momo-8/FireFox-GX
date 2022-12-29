FROM ubuntu:latest

MAINTAINER medo349medo@gmail.com

ENV DEBIAN_FRONTEND noninteractive 

COPY firefox/ /home/firefox


RUN apt-get update && apt-get -y upgrade &&\
    apt-get install -y firefox snap snapd wgetbzip2 packagekit-gtk3-module dbus-x11 libasound2-dev \
    build-essential libdbus-glib-1-dev  libgtk-3-0 \
    pulseaudio libxt6  libxext-dev libxrender-dev  libxtst-dev

RUN useradd -m normaluser

RUN wget -O ~/Firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64"

RUN  rm -rf /opt/firefox/ /usr/bin/firefox \
&&tar xjf ~/Firefox.tar.bz2 -C /opt/ \ 
&&ln -s /opt/firefox/firefox /usr/bin/ \
&& cp -r /home/firefox /home/normaluser/firefox \
    &&chmod -R ugo+rw /home/normaluser/firefox

USER normaluser

CMD firefox --profile /home/normaluser/firefox
