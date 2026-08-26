FROM php:8.2-apache
COPY . /var/www/html/
RUN chmod -R 777 /var/www/html
CMD ["sh", "-c", "if [ -d /var/www/html/s7even-parfums ]; then cp -r /var/www/html/s7even-parfums/* /var/www/html/; fi && apache2-foreground"]
EXPOSE 80
