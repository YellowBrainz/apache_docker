FROM ubuntu:latest

# Look for more in you github repo for the full project and a Makefile that
# eases the creation of this Apache docker. When you like this package then
# please give us the heads-up with your star.
#
# Enjoy!  Toon Leijtens (Code zombie at Yellowbrainz.com)

ENV DEBIAN_FRONTEND noninteractive

# Set the locale, Quartus expects en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update &&\
    apt-get -y -qq upgrade &&\
    apt-get -y -qq install apt-utils &&\
    apt-get -y -qq install apache2

# This will put the basic configuration of our cool site in place
COPY artifacts/mycoolsite.conf /etc/apache2/sites-available
COPY artifacts/apache2.conf /etc/apache2

RUN /usr/sbin/a2ensite mycoolsite

EXPOSE 80


# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
