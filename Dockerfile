FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV \
	HOME=/config \
	TZ=UTC

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

RUN \
	echo "*** fix /etc/nut/upsset.conf ***" && \
        sed -i '/I_HAVE_SECURED_MY_CGI_DIRECTORY/s/^### //' /etc/nut/upsset.conf

VOLUME ["/config/nut/www"]
