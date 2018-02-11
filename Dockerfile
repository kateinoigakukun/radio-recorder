FROM ruby:2.3

RUN echo "Asia/Tokyo\n" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get install -y \
        ntp \
        curl \
        libav-tools \
        rtmpdump \
        swftools \
        git

RUN wget --no-verbose -O /tmp/ffmpeg.tar.gz http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz \
  && tar -C /tmp -xf /tmp/ffmpeg.tar.gz \
  && mv /tmp/ffmpeg-*-64bit-static/ffmpeg /usr/bin \
  && rm -rf /tmp/ffmpeg*

WORKDIR /radio
CMD bundle install && bundle exec ruby bin/recorder
