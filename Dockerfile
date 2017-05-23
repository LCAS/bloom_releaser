
FROM ubuntu:xenial

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

RUN echo "-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: GnuPG v1\n\nmQGiBEsy5KkRBADJbDSISoamRM5AA20bfAeBuhhaI+VaiCVcxw90sq9AI5lIc42F\nWzM2acm8yplqWiehAqOLKd+iIrqNGZ+VavZEPTx7o06UZUMRoPBiTFaCwrQ5avKz\nlt7ij8PRMVWNrJ7A2lDYXfFQVV1o3Xo06qVnv0KLLUmiur0LBu4H/oTH3wCgt+/I\nD3LUKaMJsc77KwFBTjHB0EsD/26Z2Ud12f3urSNyN6VMWnP3rz6xsmtY4Qsmkbnr\nJuduxCQBZv6bX1Cr2ulXkv0fFOr+s5OyUv7zyCPbxiJFh3Br7fJGb0b5/M208KPe\ngiITY9hMh/aUbKjXCPoOXPxSL6SWOWV8taR6903EFyLBN0qno/kXIBKnVqBZobgn\njIEPA/0fTnxtZtE7EpirGQMF2caJfv7/LCgXmRs9xAhgbE0/caoa1tnc79uaHmLZ\nFtbGFoAO31YNYM/IUHtmabbGdvZ4oYUwDhjBevVvC7aI+XhuNGK5mU8qCLLSEUOl\nCUr6BJq/0iFmjwjmwk9idZEYhqSNy2OoYJbq45rbHfbdKLEVrbQeUk9TIEJ1aWxk\nZXIgPHJvc2J1aWxkQHJvcy5vcmc+iGAEExECACAFAksy5KkCGwMGCwkIBwMCBBUC\nCAMEFgIDAQIeAQIXgAAKCRBVI7rusB+hFmk7AJ0XsLp05KA8l3YzAumZfjSN04MZ\njQCfQHfp4aQUXdOCUtetVo0QZUX3IuO5Ag0ESzLkrhAIAOCuSC83VXYWf8gOMSzd\nxwpsH/uLV9Wze2LGnajsJLjEOhcsz2BHfxqNXhYaE9aQaodPCpbUAkPq8tLbpXy0\nSWRCx0F5RcplXx5vIWbP6TlfPbRpK70w7IWd6vsNrjwEHjlhOLcNcj42sp5pgx4b\ndceK06k5Ml2hYovPnD9o2TYgjOqg5FHZ2g1J0103n/66bN/hZnpLaZJYQiPWCyq6\nK0565i1k2Y7hgWB/OXqwaqCehqmLTvpyQGzE1UJvKLuYU+T+4hBnSPbT3KIi5fCz\nlIwvxijOMcfbkLhzYQXcU0Rd1VItcd5nmPL4z97jBxzuhkgxXpGR4WGKhvsA2Z9Y\nUtsAAwYH/3Bf44bTpD9bVADUdab3e7zm8iHfh9K/a83mIgDB7mHV6WuemQVTf/1d\neu4mI5WtpbOCoucybGfjGIIAcSxwIx6VfC7HSp4J51bOpHhbdDffUEk6QVsZjwoF\nyn3W9W3ZVeTI+ch/Qoo5a98SnmdjN8eXI/qCuiXOHc6rXDXc2R0iox/1EAS8xGVd\ncYZe7IWBO2CjCknyhLrWxZHoy+i1GCZ9KvPF/Ef2dmLhCydT73ZlumsY8N5vm76Q\nul1G7f8LNbnMgXQafRkPffrAXSVhGY3Z2IiBwFNgxcKTq479l7yedYRGeU1A+SYI\nYmRFWHXt3rTkMlQSpxCsB0fAYfrwEqqISQQYEQIACQUCSzLkrgIbDAAKCRBVI7ru\nsB+hFpryAJ9qNz3h3ijt9TkAV0CHufsPT6Cl4gCglfg7tJn2lsSF3HTpoDDO1Fgg\nx9o=\n=AGYp\n-----END PGP PUBLIC KEY BLOCK-----\n" > /tmp/keys/1.key && apt-key add /tmp/keys/1.key

RUN echo deb http://10.210.9.154/ubuntu/building xenial main | tee -a /etc/apt/sources.list.d/buildfarm.list
RUN echo deb http://packages.ros.org/ros/ubuntu xenial main | tee -a /etc/apt/sources.list.d/buildfarm.list

RUN apt-get update
RUN apt-get install -y git ros-kinetic-catkin python-bloom

#RUN pip3 install jenkinsapi bloom catkin_tools catkin-tools-python urlparse3

RUN echo "source /opt/ros/kinetic/setup.bash" >> /etc/bash.bashrc

RUN rosdep init

USER buildfarm

WORKDIR /home/buildfarm

RUN mkdir -p .config/rosdistro/
RUN echo "index_url: https://raw.githubusercontent.com/lcas/rosdistro/master/index.yaml" > .config/rosdistro/config.yaml

RUN git clone https://github.com/LCAS/bloom_releaser.git

ENV BLOOM_DONT_ASK_FOR_DOCS=1
ENV BLOOM_DONT_ASK_FOR_SOURCE=1
ENV BLOOM_DONT_ASK_FOR_MAINTENANCE_STATUS=1 
ENV BLOOM_NO_WEBBROWSER=1

ENV LANG="en_US.UTF-8"
# This is needed for bloom to work properly:
ENV PYTHONIOENCODING="UTF-8"
ENV ROS_DISTRO="kinetic"
ENV REPO="sandbox"

#ENV REPO="https://github.com/lcas/sandbox.git"

RUN git config --global user.email "lcas-build-farm@googlegroups.com"
RUN git config --global user.name "LCAS build farm"
RUN git config --global credential.helper 'store'

RUN rosdep update

#RUN bloom-release --non-interactive -t $ROS_DISTRO -r $ROS_DISTRO $REPO
#RUN bloom-release -n -t $ROS_DISTRO -r $ROS_DISTRO $REPO

COPY "$GIT_CREDENTIALS" .git-credentials

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/home/buildfarm/releaser.sh"]


