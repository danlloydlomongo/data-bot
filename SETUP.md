# Setup Guide

Two steps to get all apps running. Env files and Laravel are preconfigured.

## Step 1: Start the stack

**Just pulled the repo?**

```bash
make run-fresh
```

This generates a new `APP_KEY` in `env/laravel.env`, rebuilds containers, and runs migrations.

**Already set up before?**

```bash
make run
```

## Step 2: Configure Host Aliases

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

---

Then open **http://data-bot.test** in your browser to verify.

## Access your services

- **Laravel App**: http://data-bot.test
- **FastAPI**: http://fastapi.test
- **Traefik Dashboard**: http://traefik.test
- **phpMyAdmin**: http://pma.test
- **Mongo Express (MongoDB)**: http://mongo.test
- **WebSocket Server**: http://ws.test

## Troubleshooting

| Command | Description |
|---------|-------------|
| `make run-fresh` | Generate APP_KEY, fresh rebuild + run migrations |
| `make run` | Start services |
| `make down` | Stop services |
| `make logs` | View logs |
| `make logs s=laravel` | Logs for specific service |
| `make restart` | Restart services |
| `make fresh` | Destroys volumes (keeps images) |
| `make shell` | Laravel container shell |
| `make artisan cmd="command"` | Run Laravel artisan commands |
| `make help` | Show all available commands |
