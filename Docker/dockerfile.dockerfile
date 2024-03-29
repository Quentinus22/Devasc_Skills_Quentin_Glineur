# Use a base image
FROM ubuntu:20.04

# Set noninteractive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable mod_rewrite
RUN a2enmod rewrite

# Change Apache2 to listen on port 5555 and bind to all available interfaces
RUN sed -i -e 's/Listen 80/Listen 5555/' -e 's/VirtualHost \*:80/VirtualHost \*:5555/' /etc/apache2/ports.conf
RUN sed -i 's/\<VirtualHost \*\>/\<VirtualHost \*:5555\>/' /etc/apache2/sites-enabled/000-default.conf

# Copy custom home page
COPY files/index.html /var/www/html/index.html

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]