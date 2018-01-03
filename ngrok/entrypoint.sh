#!/bin/sh -e

NGROK_PORT="${NGROK_PORT:-80}"

if [ -n "$NGROK_USERNAME" ] && [ -n "$NGROK_PASSWORD" ] && [ -n "$NGROK_AUTH" ]; then
  AUTH="\"$NGROK_USERNAME:$NGROK_PASSWORD\""
fi

cat >> /home/ngrok/.ngrok2/ngrok.yml << EOL
authtoken: "${NGROK_AUTH}"
region: ${NGROK_REGION}
log: stdout
tunnels:
  http:
    proto: http
    addr: "http:${NGROK_PORT}"
    auth: "${AUTH}"
    subdomain: "${NGROK_SUBDOMAIN}"
    hostname: "${NGROK_HOSTNAME}"
    host_header: "${NGROK_HEADER}"
EOL
    
if [ ${NGROK_SSH} = true ]; then
  cat >> /home/ngrok/.ngrok2/ngrok.yml << EOL
  ssh:
    proto: tcp
    addr: "workspace:${NGROK_SSH_PORT}"
    remote_addr: "${NGROK_SSH_REMOTE_ADDR}"
EOL
fi 

ARGS="ngrok start --all"

set -x
exec $ARGS
