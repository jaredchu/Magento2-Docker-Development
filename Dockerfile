ARG PHPFPM_IMAGE

FROM $PHPFPM_IMAGE

# ARG for USER_ID needs to be here because of build scope
# ref https://docs.docker.com/compose/compose-file/ -> Scope of build-args
ARG USER_ID

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
    curl \
    nano \
    sudo \
    cron

# Prepare for install xls
RUN apt-get install -y libxml2-dev libxslt-dev

# Prepare for install libsodium
RUN apt-get install -y libsodium-dev
RUN pecl install libsodium

# Prepare for install intl
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl

# Prepare for install gd
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl sodium bcmath intl soap xsl sockets gd mysqli

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user to fix permission issue
RUN groupadd -g $USER_ID www
RUN useradd -u $USER_ID -ms /bin/bash -g www www
RUN chown -R www:www /var/www

# Create composer folder
RUN mkdir /home/www/.composer
RUN chown -R www:www /home/www/.composer

# Add www user to sudoers and make it can run without password prompt
RUN usermod -aG sudo www
RUN echo "www ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
