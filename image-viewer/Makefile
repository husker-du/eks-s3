AWS_REGION := eu-west-1
ACCOUNT_ID := $(shell aws sts get-caller-identity --query Account --output text)
REPOSITORY := ${ACCOUNT_ID}.dkr.ecr.$(AWS_REGION).amazonaws.com
IMAGE_NAME := demo-dev-ecr-image-viewer
APP_VERSION := $(shell node -p "require('./package.json').version")

.PHONY: install
install:
	yarn install

.PHONY: start
start: install
	yarn start

.PHONY: install build
build:
	@echo "\nBuilding application..."
	yarn build
	@echo "\nBuilding docker image..."
	docker buildx build -t $(REPOSITORY)/$(IMAGE_NAME):$(APP_VERSION) .

.PHONY: login
login:
	aws ecr get-login-password --region $(AWS_REGION) | \
		docker login --username AWS --password-stdin \
		$(REPOSITORY)

.PHONY: push
push: login
	docker push $(REPOSITORY)/$(IMAGE_NAME):$(APP_VERSION)
