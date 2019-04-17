# Makefile

SHELL := /bin/bash

.PHONY: help
help: ## Show this help.
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: test
test: clean-cov ## Runs a series of tests against implemented bash scripts within this context.
	#./download_testing_tools.sh
	kcov --include-path=includes cov ./run_tests.sh

.PHONY: clean-cov
clean-cov: ## clean the previous testing coverage data
	mkdir -p ./cov
	rm -rf ./cov/*
