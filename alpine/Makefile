build:
	docker build --force-rm --cpu-quota=1800000 --cpuset-cpus="0-3" --cpu-shares=102400 --memory=50GB \
		-t ${repo_organization}/${repo_name}:$(VARIANT) .

push:
	docker push $(repo_organization)/$(repo_name):$(VARIANT)
