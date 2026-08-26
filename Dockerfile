FROM php:8.2-apache

# Copiar todo el contenido del repositorio
COPY . /var/www/html/

# Si los archivos están dentro de la subcarpeta s7even-parfums, moverlos a la raíz pública
RUN if [ -d "/var/www/html/s7even-parfums" ]; then \
        mv /var/www/html/s7even-parfums/* /var/www/html/ && \
        mv /var/www/html/s7even-parfums/.* /var/www/html/ 2>/dev/null || true; \
    fi

# Si existe la subcarpeta s7even_parfums (con guion bajo), moverlos también por si acaso
RUN if [ -d "/var/www/html/s7even_parfums" ]; then \
        mv /var/www/html/s7even_parfums/* /var/www/html/ && \
        mv /var/www/html/s7even_parfums/.* /var/www/html/ 2>/dev/null || true; \
    fi

# Dar permisos de lectura a Apache y de escritura a la carpeta de datos/pedidos
RUN chmod -R 755 /var/www/html && \
    mkdir -p /var/www/html/data && \
    chmod -R 777 /var/www/html/data

EXPOSE 80
