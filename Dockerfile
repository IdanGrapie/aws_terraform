# Use an official PHP image with FPM (FastCGI Process Manager)
FROM php:fpm

# Install Nginx and AWS SDK for PHP
RUN apt-get update && apt-get install -y nginx \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install aws_sdk_php

# Copy Nginx config for your site
COPY nginx-site.conf /etc/nginx/sites-available/default

# Copy the PHP application files to the container
COPY src/ /var/www/html/

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx in the foreground and PHP-FPM
CMD ["nginx", "-g", "daemon off;"]
