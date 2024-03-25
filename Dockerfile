# Use an official PHP image with FPM (FastCGI Process Manager)
FROM php:fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy Nginx config for your site
COPY nginx-site.conf /etc/nginx/sites-available/default

# Copy your PHP application files to the container
COPY src/ /var/www/html/

# Start Nginx and PHP-FPM services
CMD service nginx start && php-fpm
