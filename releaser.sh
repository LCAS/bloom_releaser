#!/bin/bash

DIR=$(dirname $(readlink -f $0))

ls ~/.git-credentials

echo "repo=$REPOSITORY"
echo "distro=$ROSDISTRO"
echo "bump=$BUMP"

#git clone https://gitsvn-nt.oru.se/iliad/software/private_sandbox.git

$DIR/bloom-rerelease.py --bump $BUMP $REPOSITORY $ROSDISTRO 2>&1
#bloom-release -y --no-web -t $ROSDISTRO  -r $ROSDISTRO $REPOSITORY
