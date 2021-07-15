NODENAME_APACHE=apache
AUTHOR=tleijtens
VERSION=latest
SUBNET=10.0.66
NETWORKNAME=etherway

build:
	docker build -t yellowdocker/apache:latest .

start: network apache

stop:
	docker stop -t 0 apache

clean:
	docker rm -f apache
	docker network rm $(NETWORKNAME)

network:
	docker network create --subnet $(SUBNET).0/16 --gateway $(SUBNET).254 $(NETWORKNAME)

apache:
	docker run -d -v /Users/smart-t/workspace/docker/apache_docker/www:/var/www -v /Users/smart-t/workspace/docker/apache_docker/www/logdir:/var/log/apache2 --net $(NETWORKNAME) --ip $(SUBNET).113 -e SUBNET=$(SUBNET) -p 80:80 -p 443:443 --name $(NODENAME_APACHE) yellowdocker/apache:latest

rmapache:
	docker rm -f $(NODENAME_APACHE)
