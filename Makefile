.PHONY: help icons docsify deploy undeploy

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
