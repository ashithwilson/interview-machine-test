###################################################
#  https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := default

.PHONY: default
default:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
###################################################

.PHONY: build
build:  ## Build docker image
	docker build -t ubuntu-ssh .

.PHONY: start-session
start-session:  ## Start the docker image and link ssh to local port 2222 AND creates a ngrok tunnel
	bin/run-docker.sh

.PHONY: view-session
view-session:  ## View the last/active screen of remote SSH session
	bin/view-session.sh

