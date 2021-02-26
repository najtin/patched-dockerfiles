Create the volume before you start the server.
`docker volume create ts3server-data`.
Then add you files to the volume.

The main jar files must have the name `server.jar`.

In the default configuration the port 25565 will be exposed to the host on 25565. It also maps the port 10081 to 25566, which is intended for monitoring. 