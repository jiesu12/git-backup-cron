#!/bin/sh

set -e

VOLUME='/volume'
KEY_DIR=${VOLUME}/git_backup_key

if [ ! -d /home/jie/.ssh ]
then
  if [ ! -d "${KEY_DIR}" ]
  then
    echo Need to provide git checkout key under git_backup_key directory!
    exit 1
  fi
  cp -r ${KEY_DIR} /home/jie/.ssh
  chown -R jie:jie /home/jie/.ssh
  chmod -R go-rxw /home/jie/.ssh
fi

