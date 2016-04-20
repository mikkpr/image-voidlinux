NAME =			voidlinux
VERSION =		latest
VERSION_ALIASES =
TITLE =			Void Linux
DESCRIPTION =		Void Linux
SOURCE_URL =		https://github.com/scaleway/image-voidlinux
SHELL =			/bin/bash

DEFAULT_IMAGE_ARCH =	x86_64

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Void Linux


# This is specific to distribution images
# -- to fetch latest code, run 'make sync-image-tools'
IMAGE_TOOLS_FLAVORS =   common
IMAGE_TOOLS_CHECKOUT =  276916c5288895ab02e753e138f3701c94141f64


##
## Image tools  (https://github.com/scaleway/image-tools)
##
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
