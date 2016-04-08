# What is bitlbee?

> BitlBee brings IM (instant messaging) to IRC clients. It's a great solution for people who have an IRC client running all the time and don't want to run an additional MSN/AIM/whatever client.

# How to use this image

```
$ docker run -v /opt/bitlbee/config:/etc/bitlbee -v /opt/bitlbee/users:/var/lib/bitlbee xsteadfastx/bitlbee
```

Connect your irc client to `localhost:6777` and hae fun.
