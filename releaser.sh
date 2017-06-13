#!/bin/bash

DIR=$(dirname $(readlink -f $0))

ls ~/.git-credentials

echo "repo=$REPOSITORY"
echo "distro=$ROSDISTRO"
echo "bump=$BUMP"

#git clone https://gitsvn-nt.oru.se/iliad/software/private_sandbox.git

source /opt/ros/kinetic/setup.bash

if [ "$BUMP" ]; then 
	$DIR/bloom-rerelease.py --bump $BUMP $REPOSITORY $ROSDISTRO 2>&1
fi

if [ -z "$NOBLOOM" ]; then
	bloom-release -y --no-web -t $ROSDISTRO  -r $ROSDISTRO $REPOSITORY
fi
