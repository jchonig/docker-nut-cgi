
all: build

bash: build
	docker run -it nut-cgi /bin/bash

build: true
	docker build -t nut-cgi  .

true: ;
