#!/bin/bash

ls ~/.git-credentials

echo "repo=$REPOSITORY"
echo "distro=$ROSDISTRO"

git clone https://gitsvn-nt.oru.se/iliad/software/private_sandbox.git
