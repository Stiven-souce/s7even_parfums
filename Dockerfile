FROM php:8.2-apache

# Habilitar mod_rewrite si tu tienda usa URLs amigables
RUN a2enmod rewrite

# Configurar Apache para permitir acceso total a /var/www/html/
RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/override.conf \
    && a2enconf override

# Copiar el proyecto
COPY . /var/www/html/

# Mover archivos de subcarpetas si existen
RUN if [ -d "/var/www/html/s7even-parfums" ]; then \
        cp -r /var/www/html/s7even-parfums/* /var/www/html/ 2>/dev/null || true; \
    fi && \
    if [ -d "/var/www/html/s7even_parfums" ]; then \
        cp -r /var/www/html/s7even_parfums/* /var/www/html/ 2>/dev/null || true; \
    fi

# Asignar permisos correctos al usuario de Apache (www-data)
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    mkdir -p /var/www/html/data && \
    chmod -R 777 /var/www/html/data

EXPOSE 80
