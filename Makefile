build: Dockerfile
	docker build -t kyopro-env .
build-no-cache: Dockerfile
	docker build -t kyopro-env . --no-cache
run: build
	docker run -id --name kyopro \
		-v ./src:/kyopro \
		-v ./dotfiles:/root \
		-v ./secrets/copilot:/root/.config/github-copilot \
		-v ./secrets/oj-tools:/root/.local/share/online-judge-tools \
		kyopro-env /bin/bash

shell:
	docker exec -it kyopro /bin/bash
update:
	./scripts/update.sh
