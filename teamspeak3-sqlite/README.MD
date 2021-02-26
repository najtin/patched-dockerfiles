Create the volume before you start the server.
`docker volume create ts3server-data`.
Then add you files to the volume.
Then create the file upstream.json and add the link to the local teamspeak instance like so (with the quotes):
`"http://localhost:10080/1/serverinfo?api-key=XXXXXXXXXXXXXXXXXXXXXXXXXXXX"`
Change the api-key parameter accordingly.
This is to allow secretless monitoring of the teamspeak server where the json has numbers - not quoted numbers. Your monitoring solution does not need to know about the quoted numbers or the api-key. At `host:10081` the serverinfo is provided as monitoring friendly json. 

If you dont know your api key, then you can create a new server in a temp folder. It will print the api-key to the console.
Then extract the hash from the databse and insert this hash into the database of the actual server.

```
sqlite3 ts3server.sqlitedb
select * from api_keys;
```
go to the actual server

```
sqlite3 ts3server.sqlitedb
delete from api_keys where 1=1;
insert into api_keys values (1,0,"yourvaluesXXXXXXXXXXXXXXXX",1,4,16139XXXX,16139XXXXX);
```
You now have to restart the server.

Keep in mind that every person who knows the api-key has admin priviledges on your teamspeak server.


This repository has to reside at /opt/patched-dockerfiles


Install the systemd unit and the crontab.