#!/bin/bash

# Add to your .git/config for a "git review" alias.
# 
# [alias]
#     review = "!ahi/scripts/gitreview.sh"
#
# Author: Chris Yu

if [ -z $1 ]; then
  echo "Usage: git review [reviewer] [optional cc1] [optional cc2]..."
  exit 1
fi

RECEIVE_PACK="git receive-pack --reviewer=$1@ahigames.com"
shift ## Remove $1, shift $2 to $1, etc...

for arg in "$@"
do
  RECEIVE_PACK="${RECEIVE_PACK} --cc=$1@ahigames.com"
done

git push --receive-pack='$RECEIVE_PACK' origin HEAD:refs/for/master
