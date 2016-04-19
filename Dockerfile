## -*- docker-image-name: "scaleway/voidlinux:latest" -*-
FROM multiarch/voidlinux:x86_64-latest
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM multiarch/voidlinux:armhf-latest   # arch=armv7l
#FROM multiarch/voidlinux:x86-latest     # arch=i386



MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# install packages
RUN xbps-install -Suv -y     \
 && xbps-install -S vim -y   \
 && xbps-install -S curl -y  \
 && rm -fr /var/cache/xbps/*


# make /sbin/init relative
RUN rm -f /sbin/init /bin/init    \
 && ln -s runit-init ../sbin/init


# hardcode baud for tty
RUN sed -ri 's/BAUD_RATE=([0-9]*)/BAUD_RATE=9600/g' /etc/sv/agetty-ttyS0/conf  \
 && ln -s /etc/sv/agetty-ttyS0 /etc/runit/runsvdir/current/                    \
 && rm /etc/runit/runsvdir/current/agetty-tty[1-6]

# change default shell
RUN chsh -s '/bin/bash'


# wait for scw-fetch-ssh-keys before starting sshd
RUN sed -ri 's/exec/\/usr\/local\/sbin\/scw-fetch-ssh-keys &\n\/usr\/local\/sbin\/scw-generate-ssh-keys &\nwait `jobs -p` || true\nexec/g' /etc/sv/sshd/run


# delete the root password
RUN passwd -d root


# apply overlays
COPY ./overlay-image-tools/ ./overlay/ /
