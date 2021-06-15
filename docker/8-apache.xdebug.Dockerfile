FROM laravel:8-apache

RUN /scripts/composer
RUN /scripts/xdebug

# Variáveis de ambiente
ENV APACHE_DOCUMENT_ROOT /var/www/html
ENV APACHE_SERVER_ADMIN webmaster@localhost
ENV PHP_ENABLE_XDEBUG 1
ENV DEBUG 1
ENV ENV dev

# Configurando o host do apache baseado na variável de ambiente
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Setadno o arquivo de configuração do PHP.
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Informado a saida de erro do PHP.
RUN echo "error_log=/dev/stderr" >> /usr/local/etc/php/php.ini

# Criando o arquivo de log do XDebug
RUN touch /var/log/xdebug.log
