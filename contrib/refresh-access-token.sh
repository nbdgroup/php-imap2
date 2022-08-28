#!/usr/bin/env bash

## Load environment for local testing
[ -f .env ] && source .env

## ======
## Google
## ======

## Refresh the access token
refresh_request=$(curl -s \
  -X POST \
  -d "client_id=$GOOGLE_CLIENT_ID" \
  -d "client_secret=$GOOGLE_CLIENT_SECRET" \
  -d "refresh_token=$GOOGLE_REFRESH_TOKEN" \
  -d 'grant_type=refresh_token' \
  https://accounts.google.com/o/oauth2/token)
access_token=$(echo "$refresh_request" | grep "access_token" | cut -d'"' -f4)

## Store newly access token
if [ -n "$access_token" ]; then
  gh secret set GOOGLE_ACCESS_TOKEN --body $access_token --repo javanile/php-imap2
else
  echo "Problem on refresh access token: $refresh_request"
fi
