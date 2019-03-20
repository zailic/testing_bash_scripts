# Makefile

SHELL := /bin/bash

.PHONY: help
help: ## Show this help.
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: test
test: ## Runs a series of tests against implemented bash scripts within this context.
	./download_testing_tools.sh
	./run_tests.sh


check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
					$(if $(value $1),, \
					$(error Undefined $1$(if $2, ($2))$(if $(value @), \
					required by target '$@')))
