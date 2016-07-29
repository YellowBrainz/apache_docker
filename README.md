# Yellowbrainz/Apache

Thank you for your interest in this nice little Apache instalation based on the newest Ubuntu build. With this docker configuration you can set-up a server that serves files and html documents.

The dockers provided by Yellowbrainz are open and free to use and tweak. We only ask for your kind appreciation in the form of a small little comment or star in dockerhub.

Now about his docker. You can download the image from dockerhub and immediately use it. Just create a shared /www folder in which you have a html from where you serve your static files. On windows and OSX sharing  afolder outside your Users / users folder on your local host is not a trivial thing, so here are a few helpfull hints to get you started.

#### OSX Mapping a folder from host to docker

When you are using the latest Docker, >1.12 (Beta), you are in good health. Just create a www and www/html folder and ensure that you can write in there. All the static html files (index.html as a minimum) you can put there and the fun begins.

If however you are unfortunate enough to sit on a older, so called boot2docker (Docker toolkit) configuration things are slightly more complicated.

First start a docker shell (Docker terminal provided by the Docker toolkit).  Now in this shell, first stop the machine, the add the filesystem mapping and then start the docker machine.

```script
docker-machine stop
VBoxManage sharedfolder add default --name /quartus --hostpath /quartus --automount
docker-machine start
```

Once your machine is up-and running, you need to ssh to the vm on virtualbox. In my case this vm is called ```default```.

```script
docker-machine ssh default
```

Now on the docker machine you will need to add a file in the called;

```script
sudo vi /var/lib/boot2docker/bootlocal.sh
```

You will need to edit this file as root!  The content of this file will need to be:

```script
#!/bin/sh
# mind you there is no bash in a boot2docker vm!
mkdir -p /quartus
mount -t vboxsf /quartus /quartus
```

With the above steps you have mounted /quartus on the host to the /quartus folder on the boot2docker instance. After editing, make sure that the shell script is executable;

```script
sudo chmod 755 bootlocal.sh
```

This is the moment! Now you should reboot the vm (in Virtualbox) and the system should come up with the mapped /quartus folder between host and docker container. PLEASE TEST, never trust me ;-P

When building the docker image for this Apache server you can also provide specific config files that Apache should use. These files are;

```script
apache2.conf
```
and ...
```script
mycoolsite.conf
```

Feel free to tweak these to suitte your needs. And don't forget to rebuild the docker image afterwards.

#### Basic steps to build and run the YB Apache docker

This installation comes with a Makefile and a Dockerfile. The Dockerfile should be seen as a static blue print for this docker. If you change this file then I assume you know your docker stuff. If you are a docker noob then changing this file is at your own risk. Complaints to me are fruitless in this case. So don't try :-)

Now about make.

It goes without saying that you will require a make on your system. So make sure you have make.

There are three make targets, which I will discuss now:

```script
make build
```
This target you should use to rebuild the docker image. This you should normaly do when you have changed any of the configuration files in ./artifacts or when you have changed stuff in the Dockerfile.
```script
make apache
```
With this you will run the docker and start the Apache2 server. The minute you do, Apache will read the files from /www/html and starts serving these.
In the configuartion provided, I have also included a mapping to a folder (outside www/html) from where you can serve files. Since I developed this apache docker to serve big Quartus files for the yellowbrainz/quartus docker. This is configured in apache2.conf, right at the bottom as;

```script
# Mapping file directory
Alias "/quartus" "/var/www/quartus"
```
The last target in the makefile is:

```script
make rmapache
```

I provide this target to clean-up after you aree done running the apache server. To properly close this you my need to ```docker ps``` and then ```docker stop <imageid>``` first to stop the docker container.

That's it folks! That's all there is to it to set-up an Apache server and start serving.  I would like to clarify that at running this script is at your own risk. When running it in a production context I strongly suggest you know your docker and apache stuff. I cannot be held responsible for any issues that may result from using this code.

Please share your comment in this repo to show your appreciation or flag an issue. If you like this docker file then please take a moment to star the docker at dockerhub (https://hub.docker.com/r/yellowbrainz/apache/tags/).

Produce code, eat brainz and don't get shot!

Toon Leijtens (code zombie at Yellowbrainz.com)
