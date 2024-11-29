.PHONY: help
help:
	@grep -E '^[a-zA-Z_\-\/]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docker/build
docker/build: ## build docker image
	docker build -t com.github.canary-x.node-tee-https:latest .

.PHONY: build/enclave
build/enclave: docker/build ## build nitro enclave, only works on an EC2 instance with the nitro cli
	rm -f node-tee-https.eif
	nitro-cli build-enclave --docker-uri com.github.canary-x.node-tee-https:latest --output-file node-tee-https.eif
