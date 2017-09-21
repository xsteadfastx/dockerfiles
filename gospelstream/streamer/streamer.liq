#!/usr/bin/liquidsoap -v

set("log.stdout", true)

#radio = input.alsa(device="hw:0,0")

url = "http://st02.dlf.de/dlf/02/64/mp3/stream.mp3"
dlfkultur = mksafe(input.http(url))

output.icecast(%opus(channels=1, bitrate="auto"),
 host="server",
 port=8000,
 password="hackme",
 mount="/dlfkultur.ogg",
 user="source",
 dlfkultur)
