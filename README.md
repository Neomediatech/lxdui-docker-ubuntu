## WORK IN PROGRESS - NOT WORKING

### lxdui-docker-ubuntu
A web UI for Linux containers based on LXD/LXC, dockerized version. Inspired from https://github.com/phenonymous/lxdui, but i prefer to use certified image from Ubuntu.

### Differences from original Dockerfile
The original Dockerfile (https://github.com/AdaptiveScale/lxdui/blob/master/Dockerfile) builds everything in one image, resulting bigger then splitting in two stages, build and app.
This Dockerfile first build all needed things, then copy the app in a clean image.
