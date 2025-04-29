FROM php:7.4-apache

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Copy app into container
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80