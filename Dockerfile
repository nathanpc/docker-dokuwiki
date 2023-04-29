FROM php:8-apache-bullseye

LABEL name="Dokuwiki"
LABEL maintainer="Nathan Campos <nathan@innoveworkshop.com>"

# Install extensions required by Dokuwiki.
RUN curl -sSLf \
		-o /usr/local/bin/install-php-extensions \
		https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
	chmod +x /usr/local/bin/install-php-extensions && \
	install-php-extensions xml mbstring zip intl gd

# Install some system utilities.
RUN apt-get update && apt-get install -y \
	unzip \
	&& rm -rf /var/lib/apt/lists/*

# Change Apache's default ports for unpriviledged ones.
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf && \
	sed -i 's/Listen 443/Listen 8443/g' /etc/apache2/ports.conf

# Enable PHP error reporting.
RUN { \
		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
		echo 'display_errors = On'; \
		echo 'display_startup_errors = On'; \
		echo 'log_errors = On'; \
		echo 'error_log = /dev/stderr'; \
		echo 'log_errors_max_len = 1024'; \
		echo 'ignore_repeated_errors = On'; \
		echo 'ignore_repeated_source = Off'; \
		echo 'html_errors = On'; \
	} > /usr/local/etc/php/conf.d/error-logging.ini

# Set the entire application as a volume.
VOLUME /var/www/html
WORKDIR /var/www/html

# Copy our entrypoint script.
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
