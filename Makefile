repo_organization = skycatch
repo_name = $(shell basename $(shell git config --get remote.origin.url) | cut -d. -f1)
VARIANTS = alpine alpine-arm64v8

build:
	for variant in $(VARIANTS); do \
		repo_organization=$(repo_organization) \
		repo_name=$(repo_name) \
		VARIANT=$$variant \
		make -C $$variant; \
	done

push:
	for variant in $(VARIANTS); do \
		repo_organization=$(repo_organization) \
    	repo_name=$(repo_name) \
		VARIANT=$$variant \
		make push -C $$variant; \
	done
