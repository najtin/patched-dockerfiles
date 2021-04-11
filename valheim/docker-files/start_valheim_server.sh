export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
NAME="Name"
PORT=2456
WORLD="Dedicated"
PASSWORD="PASSWORD"


echo "Starting server PRESS CTRL-C to exit"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
/home/valheim/valheim/valheim_server.x86_64 -name "$NAME" -port $PORT -world "$WORLD" -password "$PASSWORD"

export LD_LIBRARY_PATH=$templdpath
