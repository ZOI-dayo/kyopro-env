build: Dockerfile
	docker build -t kyopro-env .

shell:
	docker exec -it kyopro-env /bin/bash
update:
	./scripts/update.sh
