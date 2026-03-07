# First-Time Setup Guide

Follow these steps to get your data-bot project up and running:

## Step 1: Configure Host Aliases

Add the following entries to your `/etc/hosts` file (requires sudo):

```bash
sudo bash -c 'cat >> /etc/hosts << EOF

# Data Bot Development Domains
127.0.0.1 traefik.test
127.0.0.1 pma.test
127.0.0.1 data-bot.test
127.0.0.1 fastapi.test
127.0.0.1 mongo.test
127.0.0.1 ws.test
EOF'
```

Or manually edit `/etc/hosts` and add the entries above.

## Step 2: Configure Environment Variables

This project uses a centralized `env/` directory plus a root `.env` file:

- The root `.env` (next to `docker-compose.yml`) holds shared infrastructure settings (database, MongoDB, Soketi/Pusher, etc.). Adjust these if you need different local credentials.
- Per-service env files live in `env/` and are already wired into `docker-compose.yml` via `env_file`:
  - `env/laravel.env`
  - `env/fastapi.env`
  - `env/mariadb.env`
  - `env/phpmyadmin.env`
  - `env/mongodb.env`
  - `env/soketi.env`
  - `env/queue-worker.env`
- For normal local development you typically **don’t need to edit** these files; they have sensible defaults that match the root `.env`. If you customize settings for a specific service, edit its corresponding file under `env/`.

## Step 3: Initialize Laravel (if not already done)

If the `laravel/` directory is empty or doesn't have a Laravel installation:

```bash
make init-laravel
```

This will:
- Create a new Laravel 12 project
- Install Inertia.js + Vue 3
- Generate application key
- Set up dependencies

## Step 4: Build Docker Images

Build all Docker images:

```bash
make build
```

## Step 5: Start Services

Start all services:

```bash
make run
```

Or for development with Vite dev server:

```bash
make run-dev
```

## Step 6: Verify Services

Check that all services are running:

```bash
docker compose ps
```

## Step 7: Access Your Services

Once running, you can access:

- **Laravel App**: http://data-bot.test
- **FastAPI**: http://fastapi.test
- **Traefik Dashboard**: http://traefik.test
- **phpMyAdmin**: http://pma.test
- **WebSocket Server**: http://ws.test

## Step 8: Run Laravel Migrations (if needed)

If you have migrations:

```bash
make artisan cmd="migrate"
```

## Troubleshooting

### View logs:
```bash
make logs              # All services
make logs s=laravel    # Specific service
```

### Restart services:
```bash
make restart
```

### Fresh start (destroys volumes):
```bash
make fresh
```

### Shell into Laravel container:
```bash
make shell
```

## Quick Reference

- `make help` - Show all available commands
- `make run` - Start services
- `make down` - Stop services
- `make logs` - View logs
- `make artisan cmd="command"` - Run Laravel artisan commands
- `make shell` - Access Laravel container shell
