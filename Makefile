NODENAME_APACHE=apache
AUTHOR=tleijtens
VERSION=latest

build:
	docker build -t yellowdocker/apache:latest .

apache:
	docker run -i -v /www:/var/www -v /www/logdir:/var/log/apache2 -p 80:80 -p 443:443 --name $(NODENAME_APACHE) yellowdocker/apache:latest

rmapache:
	docker rm -f $(NODENAME_APACHE)
