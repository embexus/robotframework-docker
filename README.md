# Docker for Robot 

Docker Image with Debian Bullseye and all dependencies to work with robotframework

## Generate Docker Image

        sudo docker build --build-arg USER=${USER} --build-arg UID=${UID} --rm=true --tag robotframework-docker .
        
## Run Docker Image

       sudo docker run --rm --privileged -ti -h robotframework \
             -v ${HOME}:${HOME} robotframework-docker
