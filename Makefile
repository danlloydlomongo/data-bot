.PHONY: help build up up-dev down restart logs shell artisan tinker init-laravel fresh

DOCKER_COMPOSE = docker compose

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build all Docker images
	$(DOCKER_COMPOSE) build

run: ## Start all services
	$(DOCKER_COMPOSE) up -d

run-dev: ## Start all services + Vite dev server
	$(DOCKER_COMPOSE) --profile dev up -d

down: ## Stop all services
	$(DOCKER_COMPOSE) down

restart: ## Restart all services
	$(DOCKER_COMPOSE) restart

logs: ## Tail logs (usage: make logs or make logs s=laravel)
	$(DOCKER_COMPOSE) logs -f $(s)

shell: ## Shell into Laravel container
	$(DOCKER_COMPOSE) exec laravel sh

artisan: ## Run artisan command (usage: make artisan cmd="migrate")
	$(DOCKER_COMPOSE) exec laravel php artisan $(cmd)

tinker: ## Open Laravel Tinker
	$(DOCKER_COMPOSE) exec laravel php artisan tinker

init-laravel: ## Scaffold Laravel 12 with Inertia + Vue
	mkdir -p laravel
	$(DOCKER_COMPOSE) build laravel
	$(DOCKER_COMPOSE) run --rm laravel sh -c "composer create-project laravel/laravel /tmp/laravel-app && cp -a /tmp/laravel-app/. /var/www/html/"
	$(DOCKER_COMPOSE) run --rm laravel php artisan key:generate
	$(DOCKER_COMPOSE) run --rm laravel composer require inertiajs/inertia-laravel
	$(DOCKER_COMPOSE) run --rm laravel sh -c "npm install && npm install @inertiajs/vue3 vue @vitejs/plugin-vue"
	@echo ""
	@echo "✔ Laravel project scaffolded with Inertia + Vue."
	@echo "  Run 'make up' to start all services."

fresh: ## Destroy volumes and rebuild everything
	$(DOCKER_COMPOSE) down -v
	$(DOCKER_COMPOSE) up -d --build
