FROM resin/rpi-raspbian

RUN apt-get update
RUN apt-get install alsa-utils libasound2-plugin-equal gettext git -y

RUN git clone https://github.com/Arkq/bluez-alsa.git
RUN autoreconf --install
RUN mkdir build && cd build
RUN ../configure --enable-aac --enable-ofono --enable-debug
RUN make && make install

RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

ENV SPOTIFY_NAME RaspotifySpeaker
ENV BACKEND_NAME 'alsa'
ENV DEVICE_NAME 'equal'
ENV ALSA_SLAVE_PCM 'plughw:0,0'
ENV ALSA_SOUND_LEVEL '100%'
ENV VERBOSE 'false'
ENV EQUALIZATION ''

ADD /asound.conf /
ADD /equalizer.sh /

ADD /startup.sh /
CMD /startup.sh
