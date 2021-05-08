#!/bin/sh

export UN=$(id -nu)
sudo docker run -it \
    -v ~/.tc_cache:/home/${UN}/.tc_cache \
    -v ~/.ssh:/home/${UN}/.ssh:ro \
    -v ~/.ssh_host:/home/${UN}/.ssh_host:ro \
    -v ~/Desktop/vewd_projects/depot_tools:/home/${UN}/depot_tools \
    -v /tvsdk:/tvsdk \
	-v /home/${UN}/Desktop/vewd_projects/tvsdk-amber:/home/${UN}/tvsdk-amber \
    -v ~/bin:/home/${UN}/bin \
    -v ~/.third_party_package_cache:/home/${UN}/.third_party_package_cache \
    -w /home/${UN}/ \
    tvsdk-build-sys:latest /bin/bash
