# docker-nut-cgi
A container with the CGI tools of [Network UPS
Tools](https://networkupstools.org) and fcgiwrap to be used in
conjunction with an nginx container.  Many nginx containers are based
on alpine which does not have the Nut CGI tools available.

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
	  - /path/to/nginx/config/nut:/config/nut
	expose:
	  - 8081
    restart: unless-stopped

   nginx:
     ...
   volumes:
     - /path/to/nginx/config:/config
   restart: unless-stopped
```

# Parameters

## Environment Variables (-e)

| Env | Function |
| --- | -------- |
| PUID=1000 | for UserID - Set to UID that will run SpiderOak ONE  |
| PGID=1000 | for GroupID - Set to GID that will run SpiderOak ONE |
| TZ=UTC    | Specify a timezone to use EG UTC                     |

## Volume Mappings (-v)

| Volume          | Function                                                       |
| ------          | --------                                                       |
| /config/www/nut | The Nut HTML files from /usr/share/nut/www will be copied here |

# Application Setup


## REFERENCE

### CREDIT

