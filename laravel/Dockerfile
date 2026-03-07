FROM php:8.3-fpm-alpine AS php-base

# Install system dependencies needed by PHP and extensions
RUN apk add --no-cache \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    openssl-dev \
    linux-headers \
    autoconf \
    g++ \
    make

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        opcache \
        sockets

# Install PECL extensions
RUN pecl install redis mongodb \
    && docker-php-ext-enable redis mongodb

# Allow PHP-FPM to read container environment variables
RUN sed -i 's/;clear_env = no/clear_env = no/' /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www/html


# ---------- Composer / PHP dependencies builder ----------
FROM php-base AS php-deps

# Install Composer only in this stage
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files first for better layer caching
COPY composer.json composer.lock ./

RUN composer install \
    --no-dev \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --optimize-autoloader


# ---------- Frontend assets builder (Vite) ----------
FROM node:22-alpine AS assets

WORKDIR /app

COPY package*.json vite.config.js ./
RUN npm ci

COPY resources resources
RUN npm run build


# ---------- Final runtime image ----------
FROM php-base AS runtime

WORKDIR /var/www/html

# Copy application source
COPY . .

# Copy vendor from the composer build stage
COPY --from=php-deps /var/www/html/vendor ./vendor

# Copy built frontend assets into public directory
COPY --from=assets /app/public ./public

# Entry point script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
