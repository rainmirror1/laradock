#!/bin/sh -e

ARGS="ngrok tcp"

# Set the authorization token.
if [ -n "$NGROK_AUTH" ]; then
  ARGS="$ARGS -authtoken=$NGROK_AUTH "
fi

if [ -n "$NGROK_REMOTE_ADDR" ] && [ -n "$NGROK_AUTH" ]; then
  ARGS="$ARGS -remote-addr=$NGROK_REMOTE_ADDR "
fi

# Set a custom region
if [ -n "$NGROK_REGION" ]; then
  ARGS="$ARGS -region=$NGROK_REGION "
fi

ARGS="$ARGS -log stdout"

ARGS="$ARGS workspace:22"

set -x
exec $ARGS
