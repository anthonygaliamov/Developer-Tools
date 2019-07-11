#!/bin/bash

Password = "password"

spawn brew cask install java
expect "Password:"
send $Password + "\r"
interact


# Check if path has 'spaces'
if [[ $RUNDIR = *" "* ]]; then
  echo "Path contains one or more spaces. To create Keystores, path cannot have spaces."
else
  echo "Path contains one or more spaces."
  exit 1 # Fail and exit script
fi