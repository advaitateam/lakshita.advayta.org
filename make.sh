#!/bin/sh

case $1 in

run-dev)
  hugo serve
  ;;

install)
  mkdir -p dist/
  ;;

lint)
  echo 'todo'
  ;;

build)
  BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
  hugo --mode $BRANCH_NAME
  ;;

deploy-dev)
  BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
  SHORT_SHA=`git rev-parse --short HEAD`
  echo $BRANCH_NAME, $SHORT_SHA
  SHORT_SHA=$SHORT_SHA BRANCH_NAME=$BRANCH_NAME hugo
  cp -rf assets public/
  # yarn add --global wrangler
  wrangler pages deploy public --project-name="lakshita-advayta-org" --commit-dirty true --branch master --commit-hash $SHORT_SHA --commit-message $SHORT_SHA
  ;;


help)
  cat make.sh | grep "^[a-z-]*)"
  ;;

*)
  echo "unknown $1, try help"
  ;;

esac
