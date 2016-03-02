letsencrypt webroot container client
============================

im still struggling to get a nice [letsencrypt](https://letsencrypt.org/) workflow. if using the official client there is some self updating before every run going on. thats good because its still beta and stuff. but because im playing around with docker the last months, i thought i could put everything together in a really small (thanks to [alpine linux](https://hub.docker.com/_/alpine/)) container.

running the container
---------------------

get everything with `git clone https://github.com/xsteadfastx/letsencrypt_docker`.

im a big fan of [docker-compose](https://docs.docker.com/compose/). i try to define everything in a nice `docker-compose.yml` file. like this i can rebuild an image and run the container with all bells and whistles i want them too. no strange self written bash script to get the container running. and its easy to handle more containers if needed (like a mariadb one or whatever).

the `docker-compose.yml` for this looks like:

```
letsencrypt:
  build: letsencrypt/
  volumes:
    - /etc/letsencrypt:/etc/letsencrypt
    - /var/lib/letsencrypt:/var/lib/letsencrypt
  environment:
    EMAIL: marvin@xsteadfastx.org
    WEBROOTPATH: /etc/letsencrypt/webrootauth
  command:
    "-d emby.xsteadfastx.org -d cloud.xsteadfastx.org -d reader.xsteadfastx.org -d git.xsteadfastx.org"
```

we need mount the actually letsencrypt location volumes and define an email address (this is needed by letsencrypt.org) and the webrootpath. thats where the client webroot authenticator puts some magic files and gets authenticated. its the root directory for the nginx snippet. for `command` we define all the domains we want some certs for. its always a `-d` followed by the domain.

run it with `docker-compose up`

nginx snippet
-------------

nginx needs a little snippets that the webroot-authenticator works in the right way. thanks to [Leliana](https://community.letsencrypt.org/t/using-the-webroot-domain-verification-method/1445/7) for this snippet.

```
 location /.well-known/acme-challenge {
    alias /etc/letsencrypt/webrootauth/.well-known/acme-challenge;
    location ~ /.well-known/acme-challenge/(.*) {
        add_header Content-Type application/jose+json;
    }
}
```

this snippet needs to be included in all the server sections for the domains we want to use. for example:

```
 server {
	listen 80;
	server_name cloud.xsteadfastx.org;
	include snippets/letsencryptauth.conf;
	return 301 https://$server_name$request_uri;
}

server {
        #listen [::]:443;
        listen 443;
        server_name cloud.xsteadfastx.org;

	ssl on;
	ssl_certificate /etc/letsencrypt/live/cloud.xsteadfastx.org/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/cloud.xsteadfastx.org/privkey.pem;

	include snippets/letsencryptauth.conf;

	client_max_body_size 20G;

	location / {
		proxy_pass http://127.0.0.1:9998;
		proxy_set_header X-Forwarded-Host $server_name;
                proxy_set_header X-Forwarded-Proto https;
                proxy_set_header X-Forwarded-For $remote_addr;
	}

}
```

now letsencrypt should be able to authenticate our domains.
