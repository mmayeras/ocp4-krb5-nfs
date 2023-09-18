#!/bin/sh

[[ -z "$ACCOUNT_NAME" ]] && echo "*** Error: ACCOUNT_NAME not defined" && exit 1

if [[ -z "$KPASSWORD" ]]; then
  echo "*** Error: You need a password (KPASSWORD) to authenticate!"
  exit 1
fi

[[ -z "$PERIOD_SECONDS" ]] && PERIOD_SECONDS=3600

if [[ -n "$CLEAN" ]]; then
  echo "*** Removing all existing ticket"
  kdestroy -A
fi

while /bin/true; do
  echo "*** kinit at "+$(date -Is)
  if [[ -n "$KPASSWORD" ]]; then
    echo "*** using password"
    echo "$KPASSWORD" | kinit $ACCOUNT_NAME
  fi
  klist
  if [[ "$PERIOD_SECONDS" -eq "0" ]]; then
    echo "*** Kinit once, leave here"
    exit 0
  fi
  echo "**** Wait for ${PERIOD_SECONDS}sec..."
  sleep $PERIOD_SECONDS & wait $!
done