set -e
chown -R  ts3server:ts3server /opt/ts3server/
chmod -R 700 /opt/ts3server/
### ATTENTION: The server has to run as the user "ts3server"
runuser -u ts3server mv /opt/build-ts3server/* /opt/ts3server/
exec runuser -u ts3server /opt/ts3server/ts3server license_accepted=1
exec rm -r $(echo $PATH | sed 's/:/ /g')