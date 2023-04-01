FROM php:7.4.32-apache

RUN a2enmod rewrite
RUN apt-get update && \
    apt-get install -y
RUN apt-get install -y libonig-dev
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install exif
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install xml
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install opcache
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip
RUN a2dissite 000-default.conf

COPY . /var/www/html/
 
RUN mkdir /var/www/html/moodledata 
 
RUN chown -R www-data:www-data /var/www/html/moodle/ && \ 
    chmod -R 755 /var/www/html/moodle/ && \ 
    chown www-data /var/www/html/moodledata 
 
COPY moodle.conf /etc/apache2/sites-available/ 
 
RUN a2enmod rewrite && \ 
    a2ensite moodle.conf && \ 
    a2dissite 000-default.conf 
 
EXPOSE 80 
 
CMD ["apachectl","-D","FOREGROUND"]
