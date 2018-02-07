repo_organization = skycatch
repo_name = $(shell basename $(shell git config --get remote.origin.url) | cut -d. -f1)
VARIANTS = alpine alpine-arm64v8
DOCKER_VERSION = 17.10.0-r0

build:
	for variant in $(VARIANTS); do \
		repo_organization=$(repo_organization) \
		repo_name=$(repo_name) \
		VARIANT=$$variant \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		make -C $$variant; \
	done

push:
	for variant in $(VARIANTS); do \
		repo_organization=$(repo_organization) \
    	repo_name=$(repo_name) \
		VARIANT=$$variant \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		make push -C $$variant; \
	done
