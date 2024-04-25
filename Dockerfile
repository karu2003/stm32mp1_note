	FROM ubuntu:22.04

	# The following 2 lines are added to avoid hanging the container creation. See <https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d>
	ENV TZ=Europe/Brussels
	RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

	RUN apt-get update && apt-get install -y git-core diffstat \
                                             build-essential chrpath cpio debianutils \
                                             locales python3-distutils gdisk sudo \
                                             repo bsdmainutils build-essential chrpath cpio debianutils diffstat \
                                             gawk gcc-multilib git iputils-ping libegl1-mesa \
                                             libgmp-dev libmpc-dev libsdl1.2-dev libssl-dev lz4 \
                                             pylint python3 python3-git python3-jinja2 \
                                             python3-pexpect python3-pip socat texinfo \
                                             unzip wget xterm xz-utils zstd file

	RUN groupadd -g 1000 dev \
				&& useradd -u 1000 -g dev -d /home/dev dev \
				&& mkdir /home/dev \
				&& chown -R dev:dev /home/dev
	
	# The following 3 lines allow the 'dev' user to run sudo (password is "dev"). 
	# Useful when later on packages need to be installed that are missing.
	RUN usermod -aG sudo dev
	SHELL ["/bin/bash", "-o", "pipefail", "-c"]
	RUN echo 'dev:dev' | chpasswd

	RUN locale-gen en_US.UTF-8

	ENV LANG en_US.UTF-8

	USER dev

	WORKDIR /home/dev
