# ttrss_docker

## getting it running
1. `git clone https://github.com/xsteadfastx/ttrss_docker.git`
2. `cd ttrss_docker`
3. creating a data-only container for storing the database data with `docker create --name ttrss-data mariadb /bin/true`
4. edit `docker-compose.yml` and set URL_PATH environment variable
5. `docker-compose up`
6. set reverse nginx proxy. example config is belog

## nginx configuration file for the proxy
```
server {
	listen 80;
	server_name reader.foo.bar;
	return 301 https://$server_name$request_uri;
}

server {
	listen 443;
	server_name reader.foo.bar;

	ssl on;
	ssl_certificate /etc/nginx/ssl/reader.foo.bar.crt;
	ssl_certificate_key /etc/nginx/ssl/reader.foo.bar.key;

	location / {
		proxy_pass http://127.0.0.1:9998;
		proxy_set_header X-Forwarded-Host $server_name;
		proxy_set_header X-Forwarded-Proto https;
		proxy_set_header X-Forwarded-For $remote_addr;
	}

}
```
