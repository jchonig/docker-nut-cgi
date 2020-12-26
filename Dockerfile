FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV \
	HOME=/config \
	TZ=UTC

# Add SpiderOakONE from tarball
RUN \
	echo "**** install packages ****" && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		fcgiwrap nut-cgi && \
	echo "**** clean up ****" && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

COPY root /

VOLUME ["/config/nut/www"]
