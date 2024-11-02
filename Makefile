build: Dockerfile
	docker build -t kyopro-env .

shell: build
	./scripts/shell.sh
