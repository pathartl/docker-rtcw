### Return to Castle Wolfenstein Docker Container

This repository is a Docker image configuration aimed at hosting a Return to Castle Wolfenstein dedicated server as a container. It couldn't be any simpler.

#### Method

The Dockerfile is pretty simple. I did want to point out that on build this actually downloads the source from id's GitHub repo and compiles it. I could not find any vanilla binaries for Linux, so this will have to do.

#### Launching

Before you do anything, make sure to copy your main folder out of your legit RTCW installation directory and replace the main folder from this repository.

Not all files in main are needed. I believe all you need are the `mp_pak*.pk3` files and `pak0.pk3`.

##### Docker Compose

I've created a `docker-compose.yml` file for easy starting of the container. Build the image using `docker build -t rtcw_server .` and then do a `docker-compose up` and it should start the server for you.

##### Manual Launch

If you need to pass other launch parameters or you don't use docker-compose you can launch the container the old fashioned way.

```docker run -d -v /path/to/docker-rtcw/main/:/root/.wolf/main/ -p 27960:27960/udp rtcw_server```

*NOTE: You need to pass the -p parameter in order to access the server!*

If you're running multiple instances on the same box you can remap the ports (in this example from the default 27960 to 27961):

```docker run -d -v /path/to/docker-rtcw/main/:/root/.wolf/main/ -p 27961:27960/udp rtcw_server```

#### Maps

I've put in a standard map rotation in `server.cfg`. Really though you should remove every line except for beach :)

#### Customizing

Included in this repository is a server.cfg file in the `main` folder. You can use this to customize server settings. There's tons of resources explaining what each options does, so go wild!

#### Thanks

* Docker
* id for [releasing the source to RTCW](https://github.com/id-Software/RTCW-MP) and for some awesome childhood memories
* InAnimaTe for making an awesome [Quake 3 docker container](https://github.com/InAnimaTe/docker-quake3)