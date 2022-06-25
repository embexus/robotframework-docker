FROM debian:bullseye

# Install required Packages for the Host Development System
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3 python3-pip \
                       openssh-client bash-completion vim

# Add robot & extensions
RUN pip3 install robotframework \
                 robotframework-fritzhomelibrary \
                 robotframework-remoterunner \
                 robotframework-scplibrary \
                 robotframework-seriallibrary \
                 robotframework-sshlibrary

ARG UID
ARG USER

# Create a non-root user USER
RUN id ${USER} 2>/dev/null || useradd --uid ${UID} --create-home ${USER}
RUN apt-get install -y sudo
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

USER ${USER}
RUN echo "${USER}:${USER}" | sudo chpasswd

RUN sudo chown -R ${USER}:${USER} /home/${USER}

WORKDIR /home/${USER}
CMD ["/bin/bash"]

# EOF