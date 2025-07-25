FROM jellyfin/jellyfin:latest
LABEL maintainer="slavazais"

RUN apt update &&  \
    apt install -y id3v2 yt-dlp && \
    apt clean
