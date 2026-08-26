FROM php:8.2-cli

WORKDIR /app

COPY . /app

# Mover contenido si quedó atrapado en la subcarpeta s7even-parfums
RUN if [ -d "/app/s7even-parfums" ]; then cp -r /app/s7even-parfums/* /app/ 2>/dev/null || true; fi

# Crear carpeta de datos y dar permisos totales de lectura y escritura
RUN mkdir -p /app/data && chmod -R 777 /app

EXPOSE 10000

CMD ["php", "-S", "0.0.0.0:10000", "-t", "/app"]
