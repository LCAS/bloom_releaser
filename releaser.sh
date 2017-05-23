#!/bin/bash

DIR=$(dirname $(readlink -f $0))

ls ~/.git-credentials

echo "repo=$REPOSITORY"
echo "distro=$ROSDISTRO"

#git clone https://gitsvn-nt.oru.se/iliad/software/private_sandbox.git

$DIR/bloom-rerelease.py --bump $BUMP $REPOSITORY $ROSDISTRO 
bloom-release -y --no-web -t $ROSDISTRO  -r $ROSDISTRO $REPOSITORY
