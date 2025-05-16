APP_VERSION := $(shell node -p "require('./package.json').version")

.PHONY: install
install:
	yarn install

.PHONY: start
start: install
	yarn start

.PHONY: build
build:
	@echo -e "\nBuilding application..."
	yarn build
	@echo -e "\nBuilding docker image..."
	docker buildx build -t acme/image-viewer:$(APP_VERSION) .

.PHONY: push
push:
	docker push
