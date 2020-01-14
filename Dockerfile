# Docker configuration file that generates an image for the container in which
# the code formatting action is executed
#
# To build this image locally, run
#   docker build .
# within the directory where this file is stored.
# To execute the container locally, run
#   docker run -it IMAGE_ID
# where IMAGE_ID is the ID of the image as given in the output of 'docker build'
# or 'docker images' (which lists all images on the system). Note that this will
# fail because the Github action depends on the Github checkout action being
# executed first; this will automatically mount the repository as a volume for
# the container (you need to mimic this locally to make the action script work).
#
# To enter the container without executing the default action script (useful
# for debugging), run
#   docker run --entrypoint "" -it IMAGE_ID bash
# to override the entry point. This will start the container and automatically
# mount an interactive bash shell within the container. You can then use this
# shell to execute commands as on a normal Linux system; exit the shell to exit
# the container.

# we use a prebuilt image hosted on DockerHub
FROM bwvdnbro/skirtformat:latest

# copy the action script into the Docker container
COPY entrypoint.sh /entrypoint.sh

# make the action script the entry point of the container;
# upon boot, the container will execute this script and then exit
ENTRYPOINT ["/entrypoint.sh"]
