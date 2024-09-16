# Description: Makefile for building the docker image
IMAGE_NAME=tor

build:
	docker build -t $(IMAGE_NAME) .

start:
	docker run -d -p 80:80 -p 4242:4242 --name $(IMAGE_NAME) $(IMAGE_NAME)
	@echo "Waiting for Tor hidden service to be created..."
	@sleep 5
	@until docker exec $(IMAGE_NAME) test -f /var/lib/tor/hidden_service/hostname; do \
		echo "Waiting for Tor hidden service to be created..."; \
		sleep 5; \
	done
	@url=$$(docker exec $(IMAGE_NAME) cat /var/lib/tor/hidden_service/hostname); \
	echo -e "\033[0;32mTor is running on http://$${url}\033[0m"

stop:
	docker stop $(IMAGE_NAME)

clean:
	docker rm $(IMAGE_NAME)

fclean: stop clean
	docker rmi $(IMAGE_NAME)
