.PHONY: help icons docsify deploy undeploy lucky unlucky

help: ## list available targets
	@# Derived from Gomega's Makefile (github.com/onsi/gomega) under MIT License
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

docsify: ## provides docsified documentation from docs/ on port 3300 (+3301)
	@scripts/docsify.sh ./docs

icons: ## generate optimized SVG icons for documentation from icons/_media/... (sub)folders
	@for d in $$(find icons/_media -type d); do \
		echo "..." $${d} "-->" $${d#*/}; \
		svgo -f $${d} -o docs/$${d#*/}; \
	done

lucky: ## deploys the i-feel-lucky docker compose
	docker compose -f deployments/i-feel-lucky/docker-compose.yaml up -d

unlucky: ## undeploys the i-feel-lucky docker compose
	docker compose -f deployments/i-feel-lucky/docker-compose.yaml down
	@# compose down skips the network if another compose project created it
	@if docker network inspect ghost-in-da-edge >/dev/null 2>&1; then \
		docker network rm ghost-in-da-edge; \
	fi
