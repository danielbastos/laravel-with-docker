FROM php:8-apache

COPY ./scripts /scripts

RUN /scripts/dependences
RUN /scripts/extensions

# Habilitando o modo de reescrita do Apache
RUN a2enmod rewrite

# Variáveis de ambiente
ENV APACHE_DOCUMENT_ROOT /var/www/html
ENV APACHE_SERVER_ADMIN webmaster@localhost

# Configurando o host do apache baseado na variável de ambiente
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Setadno o arquivo de configuração do PHP.
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Informado a saida de erro do PHP.
RUN echo "error_log=/dev/stderr" >> /usr/local/etc/php/php.ini

#COPY . /var/www/html/
WORKDIR /var/www/html/