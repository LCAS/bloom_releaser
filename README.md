# A Docker container for releasing software via catkin and bloom

## Useful commands to build and launch the docker container

1. `docker build -t bloom_releaser .`
2. `docker run -it --rm bloom_releaser`

## Useful commands inside the container

1. `catkin_generate_changelog`
2. `bloom-release -y -t $ROS_DISTRO -r $ROS_DISTRO $REPO` (auto run)
3. `bloom-release -n -t $ROS_DISTRO -r $ROS_DISTRO $REPO` (new track)
