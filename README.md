### Backend Assessment Questions: Docker

#### Have you ever built a multi-stage Dockerfile? If yes, walk us through why you split the stages the way you did and what it saved you.

Yes. I like to split it into:

- **Build stage** – installs all tools (Composer, Node, compilers) and builds the app (dependencies and assets).
- **Runtime stage** – is a smaller image that just has what is needed to run the app.

This makes the final image **smaller, faster to pull, and safer**, because the compilers and dev tools don’t ship in production.

---

#### If two containers need to talk to each other but neither should be exposed to the outside world, how do you set that up?

- Put them on the **same Docker network**.
- **Do not** publish their ports to the host (`ports:`).
- Let them talk to each other using the **service name as hostname**, for example `http://db:5432`.

This way they can see each other, but the outside world cannot reach them directly.

---

#### What is the difference between a bind mount and a named volume, and when would you use one over the other?

- **Bind mount** (`./code:/app`):
  - Points to a real folder on your machine.
  - Good for **development**, so changes you make in your editor show up immediately in the container.

- **Named volume** (`mydata:/var/lib/phpmyadmin/data`):
  - Managed by Docker, not a specific folder you see.
  - Good for **database or other persistent data** where you just want Docker to keep it safe.

Short version is **bind mount = live dev code; named volume = long‑term data.**

---

#### Your database container starts before your app is ready and the app crashes on boot because the connection is not available yet. How do you solve that?

I handle it in a couple of ways:

- Let the **app retry the database connection** a few times instead of dying immediately.
- Use a **small “wait for DB” script** in the app’s entrypoint that checks `db:port` in a loop before starting the app.
- Optionally add a **healthcheck** to the DB and use `depends_on: condition: service_healthy` in `docker-compose.yml`.

The goal is **don’t start the app for real until the database is ready**.

---

#### What does a production Dockerfile look like versus a development one? What changes and why?

I haven’t really shipped a “real” production Dockerfile yet, but this is how I understand the difference:

- **Production Dockerfile (goal)**:
  - Use **multi-stage builds**.
  - Only include what is needed to **run** the app (no dev tools).
  - Build assets and dependencies during the image build, so the container just starts and runs.

- **Development Dockerfile / setup (what I use more today)**:
  - Has extra tools and uses **bind mounts** so code changes show up immediately.
  - Often runs the app with **hot reload** (e.g. `npm run dev`, `uvicorn --reload`).

So **prod should be small and locked‑down; dev is more relaxed and convenient for coding**.

---

#### Walk us through how you would handle environment-specific configuration — dev, staging, prod — without duplicating your entire compose file.

So far I’ve only really done this for **dev**, but this is how I think about it for all environments:

- Have one main `docker-compose.yml` with everything that is **common**.
- Add small **override files** like `docker-compose.dev.yml` and `docker-compose.prod.yml` for the differences.
- Use different **env files** (`.env.dev`, `.env.prod`) for the actual values.

Example:

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

This way you don’t have to copy‑paste the whole compose file for each environment.

---

#### How do you make sure a secret like a database password never ends up in your image or your git history?

- **Never** write secrets directly into code, Dockerfiles, or committed compose files.
- Put secrets in **env files** that are **git‑ignored** (for example `.env`) or in a secret manager.
- Pass them into containers using **environment variables** or Docker/Kubernetes secrets at runtime.

**Code and images only know about “DB_PASSWORD”, not the actual value**.

---

#### Your container is running but the app inside it is hanging. It is not crashing, just unresponsive. How do you debug that without restarting it?

For my dev setup, I would:

- Get a shell into it: `docker exec -it <container> sh`.
- Check:
  - Processes: `ps aux`.
  - Logs: `docker logs <container>`.
  - Network: try `curl` or `ping` to any services it talks to (DB, API).
- See if it’s stuck waiting on a slow dependency (like the database) or maybe using too much CPU or memory.
- On Mac/Windows, **Docker Desktop** gives you logs, stats, and a shell in the UI. On Linux/WSL, use `docker logs` and `docker exec` from the CLI.

So in development I basically treat the container like a small machine and **look around inside it while it’s stuck**.

---

#### What is a health check and why does it matter beyond just "is the container running"?

A **health check** is a small command Docker runs inside the container to see if the app is really OK.

Example:

- For a web app: call `http://localhost/health` and return success if it works.

This matters because a process can be **running but broken**. A health check lets Docker or your orchestrator:

- Mark the container as **unhealthy** and restart it.
- Stop sending traffic to it until it’s healthy again.

---

#### If you had to bring an entire stack up — app, database, reverse proxy — run migrations, and seed data, all in one command, how would you build that?

I would:

- Put everything in **Docker Compose**: app, DB, reverse proxy.
- Add a Makefile target that runs `docker compose down -v`, rebuilds and starts the stack, then runs `php artisan migrate --force` and `php artisan db:seed --force` via `docker compose exec` on the app container.
- A single command like:

```bash
make run-fresh
```

That does exactly that: **starts all containers from scratch and prepares the database**.

