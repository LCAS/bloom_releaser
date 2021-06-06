
FROM ubuntu:xenial
ARG GIT_CREDENTIALS
ARG BLOOM_TOKEN
LABEL description="bloom-releaser"

VOLUME ["/var/cache/apt/archives"]

ENV DEBIAN_FRONTEND noninteractive

RUN for i in 1 2 3; do apt-get update && apt-get install -q -y locales && apt-get clean && break || if [[ $i < 3 ]]; then sleep 5; else false; fi; done
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ GMT+00
RUN useradd -u 108 -m buildfarm

RUN mkdir /tmp/keys
RUN echo "-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: GnuPG v1.4.11 (GNU/Linux)\n\nmQENBFPzE4sBCAC9c8hzt+gqe6YqXAW9Yd10jx68M0q8IowAe182yVtIvYf5l+qn\nMsXiDUz4l7c1TcRpdzZ1WwEQoNNjQKq51ip2Ln3Uhri/GsPBk+psIJPt5AeXYrSf\nxcDs8k4FMWgJtYMlZLuNk1YPaS6Vf1+Ygbe0u+ssORWg3cWhgLWPDydXdlhinUgw\nkPd9ZYi8aaAxi94DMuOnAjItfPbuX52NHmPR2cXuh3fZklhA6cCGRYkSVqijKhEv\n/o8fTnjcTama8ml5jnaAhcZ/4UV3terLeXEQn3+WM+VbTsEr58zca5fOv8MjC+Uh\nEBgDgnHb8/n7OgSUvv9efQgYXBRQ1mD//JaZABEBAAG0LE1hcmMgSGFuaGVpZGUg\nKFJPU0J1aWxkKSA8bWFyY0BoYW5oZWlkZS5uZXQ+iQE4BBMBAgAiBQJT8xOLAhsD\nBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDc10MYrtOYVB9cCACQwB9auPEX\nyQdVwliJMLwVihKz0AU0UCG6qra2pdXx9l5kgkQCuDV5FQqMpk/MIJPn8Zj0l1MI\n7Yn/EAqBhXjtO2BcTuUC/9epzt1p3C++vK7RSsBDXfKzZN22apIUT0njOkL9Vuoy\nJjFetmLDaZVbmFU+4ZaX3CFtBL3ewlFiT7G6StKj40JI8QJOlDOziX2OUsqZaI2T\nYh681980od3f2OfV3LPVroz7xnyECDfBaPBPaDdb8XWSNVLhuyglb15eewK0hj++\nCut3swWH02Y3yVhzFBnosqqjyzPLBQeDMOoHAPpJHRgprfIRDoUkWAXO5re3GIUQ\ncvk0d1I1jh3luQENBFPzE4sBCACmSxiM1vpPI7BpgUNAhu0B8SWptULpiYOnDHfM\nhU1u95Z5Lu/hy3sfm4BEKgLju7Y1I3jToWTwJJzgWZRr+iuuwj3fbfHCISYIK7f3\nIWGL2iM2+kLIH6E9oqRgGbJmhiwbz6OokxG0W7atdqpBxOKqhaH0AH3qRicwnuPm\nZ4/mNHYQ0vBffENewujn1bCAz4C1WB66/AXBYF8dpCP42qB5yK7FRNv4JubMmqhK\n7fkD88uu7JVGRYU+temWuJHH4WDxiCmvK8nXacFaZT1NGdTL9/2EukKLguTtZumb\noRWgFqV6WFcEnh/V/Ma51D2+K9QbCWa8Bb6c/wKOd9Ii1aDZABEBAAGJAR8EGAEC\nAAkFAlPzE4sCGwwACgkQ3NdDGK7TmFT2rwf+MzLFPn4Rkko38nctysbXm6qmk34U\nNTtqirOlxg3mWeUCp7VQGU2Rg2msdo764SxCK12OhJqlXGMd2efCoQhYbMOqG6C0\nikBZPkd5BVFuTKsAUiuVoiQd8bDaZSpO2QdE0RdHE/yYfO66pceEKkGlcjkTRFFU\nM7nTm7IQj4BBZclMLPr4fX520ZOVUepxAARMHW5A6EcHXvhXmblZOJM36fOv3T5N\nl9L5tWdt/wybaRE4xuwVSs0n7MyMlWmkQxz8Z6OQscbKmuI4tcYSbvvB5tzjLBwZ\nChb0eEZA5ePvnGofu+3JH48FmCIPveD+4kI9GhtGkCL3Q2PiPiLcSnWQWQ==\n=nFcN\n-----END PGP PUBLIC KEY BLOCK----- \n" > /tmp/keys/0.key && apt-key add /tmp/keys/0.key
RUN echo "-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: GnuPG v1\n\n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\n=p9Xy\n-----END PGP PUBLIC KEY BLOCK-----\n" > /tmp/keys/1.key && apt-key add /tmp/keys/1.key

RUN echo deb http://10.210.9.154/ubuntu/building xenial main | tee -a /etc/apt/sources.list.d/buildfarm.list
RUN echo deb http://packages.ros.org/ros/ubuntu xenial main | tee -a /etc/apt/sources.list.d/buildfarm.list

RUN apt-get update
RUN apt-get install -y git ros-kinetic-catkin python-bloom vim nano less curl python-requests

RUN mkdir -p /etc/ros/rosdep/sources.list.d
RUN curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://raw.githubusercontent.com/LCAS/rosdistro/master/rosdep/sources.list.d/20-default.list
RUN curl -o /etc/ros/rosdep/sources.list.d/50-lcas.list https://raw.githubusercontent.com/LCAS/rosdistro/master/rosdep/sources.list.d/50-lcas.list

#RUN pip3 install jenkinsapi bloom catkin_tools catkin-tools-python urlparse3

RUN echo "source /opt/ros/kinetic/setup.bash" >> /etc/bash.bashrc

#RUN rosdep init
RUN mkdir -p /etc/ros/rosdep/sources.list.d
RUN curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://raw.githubusercontent.com/LCAS/rosdistro/master/rosdep/sources.list.d/20-default.list
RUN curl -o /etc/ros/rosdep/sources.list.d/50-lcas.list https://raw.githubusercontent.com/LCAS/rosdistro/master/rosdep/sources.list.d/50-lcas.list


COPY "$GIT_CREDENTIALS" /home/buildfarm/.git-credentials
RUN mkdir -p /home/buildfarm/.config
COPY "$BLOOM_TOKEN" /home/buildfarm/.config/bloom
RUN chown -R buildfarm /home/buildfarm/.git-credentials /home/buildfarm/.config
RUN chmod 600 /home/buildfarm/.git-credentials /home/buildfarm/.config/bloom





USER buildfarm

WORKDIR /home/buildfarm

RUN mkdir -p .config/rosdistro/
RUN echo "index_url: https://raw.githubusercontent.com/lcas/rosdistro/master/index-v4.yaml" > .config/rosdistro/config.yaml


ENV BLOOM_DONT_ASK_FOR_DOCS=1
ENV BLOOM_DONT_ASK_FOR_SOURCE=1
ENV BLOOM_DONT_ASK_FOR_MAINTENANCE_STATUS=1 
ENV BLOOM_NO_WEBBROWSER=1

ENV LANG="en_US.UTF-8"
# This is needed for bloom to work properly:
ENV PYTHONIOENCODING="UTF-8"
ENV ROS_DISTRO="kinetic"
ENV REPO="sandbox"
ENV GIT_ASKPASS=/bin/true

#ENV REPO="https://github.com/lcas/sandbox.git"

RUN git config --global user.email "lcas-build-farm@googlegroups.com"
RUN git config --global user.name "LCAS build farm"
RUN git config --global credential.helper 'store'

RUN rosdep update

USER root
COPY . /home/buildfarm/bloom_releaser
RUN chown -R buildfarm /home/buildfarm/bloom_releaser
USER buildfarm

#RUN git clone https://github.com/LCAS/bloom_releaser.git


#RUN bloom-release --non-interactive -t $ROS_DISTRO -r $ROS_DISTRO $REPO
#RUN bloom-release -n -t $ROS_DISTRO -r $ROS_DISTRO $REPO


ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/home/buildfarm/bloom_releaser/releaser.sh"]
#CMD ["/bin/bash"]


