build-docker-image:
	docker build . -t caiotava/gameboy-dev

docker-push:
	docker push caiotava/gameboy-dev

.PHONY: build-docker-image  docker-push

