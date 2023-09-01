#!/bin/env sh

# Usage:
# `$0`: Ask for recording type via bemenu
# `$0 screencast`: Record both audio and screen
# `$0 video`: Record only screen
# `$0 audio`: Record only audio
# `$0 kill`: Kill existing recording
#
# If there is already a running instance, user will be prompted to end it.
#
###########################################################
#                                                         #
# MUST RUN : sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg #
#                                                         #
###########################################################

updateicon() {
    echo "$1" > /tmp/recordingicon
    pkill -RTMIN+9 "${STATUSBAR:-dwmblocks}"
}

killrecording() {
    recpid="$(cat /tmp/recordingpid)"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$recpid"
    rm -f /tmp/recordingpid
    updateicon ""
    pkill -RTMIN+9 "${STATUSBAR:-dwmblocks}"
    # even after SIGTERM, ffmpeg may still run, so SIGKILL it.
    sleep 3
    kill -9 "$recpid"
    exit
}

screencast_alsa() {
    ffmpeg \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f alsa -thread_queue_size 256 \
    -i sysdefault:CARD=Generic_1 \
    -ac 2 \
    -device /dev/dri/card0 \
    -framerate 60 \
    -f kmsgrab -thread_queue_size 256 \
    -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=w=1920:h=1080:format=nv12' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

screencast_pulse() {
    ffmpeg \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f pulse -thread_queue_size 512 \
    -i default \
    -ac 2 \
    -device /dev/dri/card0 \
    -framerate 60 \
    -f kmsgrab -thread_queue_size 512 \
    -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=w=1920:h=1080:format=nv12' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

screencast_jack() {
    ffmpeg \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f jack -thread_queue_size 256 \
    -i ffmpeg \
    -device /dev/dri/card0 \
    -framerate 60 \
    -f kmsgrab -thread_queue_size 256 \
    -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=w=1920:h=1080:format=nv12' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

overlay_alsa() {
    ffmpeg -probesize 42M \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -vaapi_device /dev/dri/renderD128 \
    -f x11grab -thread_queue_size 512 \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -r 60 \
    -i $DISPLAY \
    -f v4l2 -thread_queue_size 512 \
    -s 320x240 \
    -r 30 \
    -i /dev/video0 \
    -f alsa -thread_queue_size 256 \
    -i default \
    -ac 2 \
    -filter_complex '[1:v][2:v]overlay=x=1588:y=830,zmq=bind_address=tcp\\\://127.0.0.1\\\:1236,format=nv12,hwupload' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/overlay-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

overlay_pulse() {
    ffmpeg -probesize 42M \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f pulse -thread_queue_size 512 \
    -i default \
    -ac 2 \
    -vaapi_device /dev/dri/renderD128 \
    -f x11grab -thread_queue_size 512 \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -r 60 \
    -i $DISPLAY \
    -f v4l2 -thread_queue_size 512
    -s 320x240 \
    -r 30 \
    -i /dev/video0 \
    -filter_complex '[1:v][2:v]overlay=x=1588:y=830,zmq=bind_address=tcp\\\://127.0.0.1\\\:1236,format=nv12,hwupload' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    "$HOME/videos/recording/overlay-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

overlay_jack() {
    ffmpeg -y \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f jack -thread_queue_size 256 \
    -i ffmpeg \
    -hwaccel vaapi \
    -vaapi_device /dev/dri/renderD128 \
    -hwaccel_output_format vaapi \
    -probesize 42M \
    -f x11grab -thread_queue_size 512 \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -framerate 60 \
    -i $DISPLAY \
    -f v4l2 -thread_queue_size 512 \
    -video_size 320x240 \
    -framerate 30 \
    -i /dev/video0 \
    -filter_complex '[1:v][2:v]overlay=x=1588:y=830,zmq=bind_address=tcp\\\://127.0.0.1\\\:1236,format=nv12,hwupload' \
    -c:a libfdk_aac -b:a 128k \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/overlay-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

t_overlay_jack() {
    ffmpeg -y \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -f jack -thread_queue_size 256 \
    -i ffmpeg \
    -hwaccel vaapi \
    -vaapi_device /dev/dri/renderD128 \
    -hwaccel_output_format vaapi \
    -probesize 42M \
    -f x11grab -thread_queue_size 512 \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -framerate 60 \
    -i $DISPLAY \
    -f v4l2 -thread_queue_size 512
    -s 320x240 \
    -r 30 \
    -i /dev/video0 \
    -filter_complex '[1:v][2:v]overlay=x=1588:y=830,zmq=bind_address=tcp\\\://127.0.0.1\\\:1236,format=nv12,hwupload' \
    -c:a libfdk_aac -b:a 128k \
    -af 'azmq=bind_address+tcp\\\://127.0.0.1\\\:1235,volume=100'
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/overlay-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

stream_youtube() {
    ffmpeg \
    -threads:v 1 -threads:a 1 -filter_threads 1 -filter_complex_threads 1 \
    -vaapi_device /dev/dri/renderD128 \
    -f x11grab \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -framerate 60 \
    -thread_queue_size 512 -i $DISPLAY \
    -f alsa -thread_queue_size 512 -i sysdefault:CARD=Generic_1 \
    -c:a aac -ac 2 -b:a 128k \
    -vf 'format=nv12,hwupload' \
    -b:v 6000k -minrate 6000k -maxrate 6000k -bufsize:v 6000k \
    -c:v hevc_vaapi -qp:v 25 \
    -profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
    -f flv rtmp://a.rtmp.youtube.com/live2/<stream-key> \
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

stream_twitch() {
    -threads:v 2 -threads:a 2 -filter_threads 2 \
    -hwaccel vaapi \
    -vaapi_device /dev/dri/renderD128 \
    -hwaccel_output_format vaapi \
    -f x11grab \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -framerate 60 \
    -thread_queue_size 1024 -i $DISPLAY \
    -f alsa -i sysdefault:CARD=Generic_1 \
    -c:a aac -bsf:a hevc_mp4toannexb -ac 2 -b:a 128k \
    -vf 'format=nv12,hwupload' \
    -b:v 2400k -minrate 2400k -maxrate 2400k -bufsize:v 2400k \
    -c:v hevc_vaapi -qp:v 25 \
    -profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
    -f flv rtmp://live.twitch.tv/app/<stream-key> \
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

audio_alsa() {
    ffmpeg \
    -thread_queue_size 1024k \
    -f alsa -i sysdefault:CARD=Generic_1 \
    -c:a flac \
    "$HOME/audio-$(date '+%y%m%d-%H%M-%S').flac" &
    echo $! > /tmp/recordingpid
    updateicon "🎙️"
}

audio_pulse() {
    ffmpeg \
    -threads:a 1 -filter_threads 1 \
    -f pulse -thread_queue_size 512 \
    -i default \
    -ac 2 \
    -c:a libfdk_aac -b:a 128k \
    "$HOME/videos/recording/audio-$(date '+%y%m%d-%H%M-%S').mp3" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

audio_jack() {
    ffmpeg \
    -threads:a 1 -filter_threads 1 \
    -f jack -thread_queue_size 256 \
    -i ffmpeg \
    -c:a libfdk_aac -b:a 128k \
    -strict -2 \
    "$HOME/videos/recording/audio-$(date '+%y%m%d-%H%M-%S').mp3" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

video() {
    ffmpeg -probesize 42M \
    -threads:v 1 -filter_threads 1 \
    -f x11grab -thread_queue_size 512 \
    -video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
    -framerate 60 \
    -i $DISPLAY \
    -vf 'format=nv12,hwupload' \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/video-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

video_kms() {
    ffmpeg \
    -threads:v 1 -filter_threads 1 \
    -i ffmpeg \
    -device /dev/dri/card0 \
    -framerate 60 \
    -f kmsgrab -thread_queue_size 256 \
    -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=w=1920:h=1080:format=nv12' \
    -c:v hevc_vaapi -qp 25 \
    -strict -2 \
    "$HOME/videos/recording/video-$(date '+%y%m%d-%H%M-%S').mp4" &
    echo $! > /tmp/recordingpid
    updateicon "⏺️🎙️"
}

askrecording() {
    choice=$(printf "screencast\\noverlay\\nvideo\\nvideo selected\\naudio\\nwebcam" | bemenu -i -p "Select recording style:")
    case "$choice" in
        screencast) screencast_jack;;
        overlay) overlay_jack;;
        streamy) youtube;;
        streamt) twitch;;
        audio) audio_jack;;
        video) video_kms;;
        *selected) overlay_jack;;
        webcam) webcam;;
    esac
}

asktoend() {
    response=$(printf "No\\nYes" | bemenu -i -p "Recording still active. End recording?") &&
    [ "$response" = "Yes" ] &&  killrecording
}

case "$1" in
    screencast) screencast_jack;;
    streamy) youtube;;
    streamt) twitch;;
    audio) audio_jack;;
    video) video_kms;;
    *selected) overlay_jack;;
    kill) killrecording;;
    *) ([ -f /tmp/recordingpid ] && asktoend && exit) || askrecording;;
esac
