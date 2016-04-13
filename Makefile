NAME =			voidlinux
VERSION =		latest
VERSION_ALIASES =	rpi2-20150713 rpi2
TITLE =			Void Linux
DESCRIPTION =		Void Linux
SOURCE_URL =		https://github.com/scaleway/image-voidlinux
SHELL =			/bin/bash

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Void Linux


##
## Image tools  (https://github.com/scaleway/image-tools)
##
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
