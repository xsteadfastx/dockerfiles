#!/usr/bin/liquidsoap -v
# vim: softtabstop=4 shiftwidth=4 expandtab

set("log.stdout", true)

#radio = input.alsa(device="hw:0,0")
#radio = input.alsa(device="default")

# find this with `pacmd list-sources|grep name`
#radio = input.pulseaudio(device="alsa_input.usb-ZOOM_Corporation_H2-00.analog-stereo")
radio = input.pulseaudio()

url = "http://st02.dlf.de/dlf/02/64/mp3/stream.mp3"
dlfkultur = mksafe(input.http(url))

output.icecast(
    %opus(channels=1, bitrate="auto"),
    host="server",
    port=8000,
    password="hackme",
    mount="/radio.ogg",
    user="source",
    radio
)

output.file(
    %opus(channels=1, bitrate="auto"),
    "/archive/%Y-%m-%d/%Y-%m-%d-%H_%M_%S.opus",
    #reopen_when={0m0s},
    radio
)

output.icecast(
    %opus(channels=1, bitrate="auto"),
    host="server",
    port=8000,
    password="hackme",
    mount="/dlfkultur.ogg",
    user="source",
    dlfkultur
)

