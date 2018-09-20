#!/bin/sh

set -e

GIT_LIST_SERVICE='http://git:8888'
GIT_SERVER='ssh://git@git:2222'
VOLUME='/volume'

echo "$(date) start backing up"

cd $VOLUME
mountPoint=$(pwd)

for repo in `curl ${GIT_LIST_SERVICE}`;do
  echo [backup] git repo $repo
  if [ ! -d ${mountPoint}${repo} ];then
    echo clone to ${mountPoint}${repo}
    GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git clone --mirror ${GIT_SERVER}${repo} ${mountPoint}${repo} 
    # these reops stores binary files, don't use compression which is slow
    if [[ $repo == *"repos/photo/"* || $repo == *"repos/other/"* ]]; then
      echo [backup] set bigFileThreshold to 1 for $2
      cd ${mountPoint}${repo}
      git config --add core.bigFileThreshold 1
    fi
  else
    echo fetch in directory ${mountPoint}${repo}
    cd ${mountPoint}${repo}
    GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git fetch --all
  fi
done

echo "$(date) done backing up"
echo
