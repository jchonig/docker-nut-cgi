# docker-nut-cgi
A container with the CGI tools of [Network UPS
Tools](https://networkupstools.org) and fcgiwrap to be used in
conjunction with an nginx container.

Many nginx containers are based on alpine which does not have the Nut
CGI tools available.  This container is based on Ubuntu and installs
nut-cgi and fcgiwrap.

# Usage

### docker-compose

Compatible with docker-compose v3 schemas.

```
---
version: "3"
services:
  nut-cgi:
    image: jchonig/nut-cgi
    container_name: nut-cgi
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
	  - nut-html:/config/www/nut
      - /etc/nut/hosts.conf:/etc/nut/hosts.conf:ro
	expose:
	  - 8081
    restart: unless-stopped

   nginx:
     ...
   volumes:
     ...
	 - nut-html:/config/www/nut:ro
   restart: unless-stopped
   depends_on: nut-cgi

volumes:
  nut-html:
```

# Parameters

## Environment Variables (-e)

| Env       | Function                                             |
| ---       | --------                                             |
| PUID=1000 | for UserID - Set to UID that will run SpiderOak ONE  |
| PGID=1000 | for GroupID - Set to GID that will run SpiderOak ONE |
| TZ=UTC    | Specify a timezone to use EG UTC                     |

## Volume Mappings (-v)

| Volume          | Function                                                                      |
| ------          | --------                                                                      |
| /config/www/nut | This private volume receives a copy of /usr/share/nut/www to be used by nginx |

# Application Setup

  + Map a NUT hosts.conf file to /etc/nut/hosts.conf
  + Configure nginx to talk to the nut-cgi container for
    `cgi-bin/nut`:

```
    location /nut {
		root /config/www;
		try_files $uri/index.html =404;
        }
	location /cgi-bin/nut/ {
		gzip off;
		root /usr/lib;

		include /etc/nginx/fastcgi_params;
		fastcgi_pass nut-cgi:8081;
		fastcgi_param SCRIPT_FILENAME /usr/lib/$fastcgi_script_name;
	}
```
