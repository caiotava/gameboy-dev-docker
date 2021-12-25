build-docker-image:
	docker build . -t caiotava/gameboy-dev${VERSION}

docker-push:
	docker tag caiotava/gameboy-dev${VERSION} caiotava/gameboy-dev
	docker push caiotava/gameboy-dev${VERSION}
	docker push caiotava/gameboy-dev

.PHONY: build-docker-image  docker-push

