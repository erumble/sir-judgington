# HELP
# This will output the help for each task

.PHONY: help

help: ## You're reading this
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

task = $(filter-out rake,$(MAKECMDGOALS))

rake: ## Run a particular rake task
	@echo $(MAKECMDGOALS)
	@echo ${thing}
	docker exec sir-judgington-web-1 bundle exec rake ${task}

clean: ## Remove Docker volumes
	@echo "Run the following commands to get rid of all the data"
	@echo "-----------------------------------------------------"
	@echo "docker compose down"
	@echo "docker volume ls -q | grep sir-judgington | xargs -n 1 -I{} docker volume rm {} -f"
	@echo "rm -rf volumes/{db,web}/*"

tasks: ## List available rake tasks
	@echo "Run the rake tasks prefixed with the following:"
	@echo "  docker exec sir-judgington-web-1 bundle exec"
	@echo "-----------------------------------------------"
	docker exec sir-judgington-web-1 bundle exec rake -T

backup: ## Create a backup of the database
	docker exec sir-judgington-web-1 bundle exec rake db:backup:create

csv: ## Create CSV for all entries
	docker exec sir-judgington-web-1 bundle exec rake csv:create

%:
	@:

