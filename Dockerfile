FROM php:7.2-fpm

# Set working directory
WORKDIR /var/www

# Update APT
RUN apt-get update

# Install dependencies
RUN apt-get install -y \
    build-essential \
    default-mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Prepare for install xls
RUN apt-get install -y libxml2-dev libxslt-dev

# Prepare for install libsodium
RUN apt-get install -y libsodium-dev
RUN pecl install libsodium

# Prepare for install intl
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl sodium bcmath intl soap xsl sockets
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN chown -R www:www /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
