#!/usr/bin/bash

mjpg_streamer -i "input_uvc.so -d /dev/video2" -o "output_http.so -p 8090" &
java -jar the-computer-part/out/artifacts/pong_jar/pong.jar &
cd the-html-part
echo "starting http server, press ctrl+c to stop everything"
bash -c 'sleep 5; firefox "http://192.168.7.151:8000"' &
exec python3 -m http.server 8000 # now, it'll wait until this gets ctrl+c'ed
pkill mjpg_streamer
