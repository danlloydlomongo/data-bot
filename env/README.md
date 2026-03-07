# Environment configuration

This `env` directory is the central place to keep environment configuration for the **data-bot** apps.

Currently:

- `global.env` mirrors the values in the project root `.env` file and is the **canonical** source of shared infrastructure settings (database, MongoDB, Soketi/Pusher, etc.).
- The root `.env` file is still used by `docker compose` for variable interpolation, so keep `env/global.env` and `./.env` in sync when you change shared values.

Recommended usage:

- Store **shared** values (DB, Mongo, queue, Pusher, etc.) in `env/global.env`.
- For each app (Laravel, FastAPI, workers, etc.), add app-specific env files here as needed, for example:
  - `env/laravel.env` for Laravel-only settings.
  - `env/fastapi.env` for FastAPI-only settings.
- Optionally, you can mount this directory into containers via `docker-compose.yml` (for example `./env:/env:ro`) if you want apps to read env files directly from here.

Nothing in the application code has been changed yet; this folder is purely organizational and safe for your existing setup.

