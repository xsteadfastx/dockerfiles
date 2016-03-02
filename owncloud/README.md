# owncloud_docker

i was looking for a owncloud docker image that i can easily run behind my nginx proxy. the nginx is a "real" box and not just a docker container. so i tried to create a minimal image with php-fpm and a minimal nginx to serve everything. this is put behind my nginx. it looks like its working. yiha.

## getting it rollin.

1. `git clone https://github.com/xsteadfastx/owncloud_docker.git`
2. `cd owncloud_docker`
3. `docker-compose up`
4. fire up the nginx proxy. the config i used is below

## nginx configuration file for the proxy
```
server {
	listen 80;
	server_name cloud.foo.bar;
	return 301 https://$server_name$request_uri;
}

server {
        #listen [::]:443;
        listen 443;
        server_name cloud.foo.bar;

	ssl on;
        ssl_certificate /etc/nginx/ssl/cloud.foo.bar.crt;
        ssl_certificate_key /etc/nginx/ssl/cloud.foo.bar.key;

	client_max_body_size 20G;

	location / {
		proxy_pass http://127.0.0.1:9998;
		proxy_set_header X-Forwarded-Host $server_name;
                proxy_set_header X-Forwarded-Proto https;
                proxy_set_header X-Forwarded-For $remote_addr;
	}

}
```
