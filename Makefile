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
		-v ./secrets/ssh:/root/.ssh \
		kyopro-env
	docker exec -i kyopro /bin/bash -c "git config --global user.email $(cat ./secrets/git/email)"
	docker exec -i kyopro /bin/bash -c "git config --global user.name $(cat ./secrets/git/name)"
	docker exec -i kyopro /bin/bash -c "cd /kyopro-lib/atcoder-library; git remote set-url origin git@github.com:ZOI-dayo/atcoder-library.git"

shell:
	docker exec -i kyopro /bin/bash -c "cd /kyopro-lib/atcoder-library; git pull"
	docker exec -it kyopro /bin/bash
update:
	./scripts/update.sh
