# Dockerfile

FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git \
    && docker-php-ext-install pdo_mysql zip

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application
COPY . /var/www/html

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set correct permissions (for runtime folders)
RUN chmod -R 777 runtime web/assets

# Expose port
EXPOSE 9000

CMD ["php-fpm"]
