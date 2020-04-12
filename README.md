# Magento2 Docker Development
Simple, fast and easy way to develop Magento 2 on localhost

## Why
- Running Magento 2 project really fast on your machine.
- Just a few steps to setup.
- No extra step to deploy code from host to container.
- Easy to modify PHP, MySQL, and Nginx configurations.
- Works on Linux, macOS, and Windows.

## Default Official Images
* php:7.2-fpm
* mysql:5.7
* nginx:alpine

## Prerequisities
**All OS**: Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

**Linux:**
Install [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

**MacOS:**
Install [Docker](https://docs.docker.com/docker-for-mac/install/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

**Windows:**
Install [Docker](https://docs.docker.com/docker-for-windows/install/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

## Getting Started

##### 1. Clone the project:
```
git clone git@github.com:jaredchu/Magento2-Docker-Development.git [project_name]
```
##### 2. Copy your project's code into `src` folder.
##### 3. Run the containers:
```
docker-compose up -d
```
If it's a new project then you can now **jump to [step 9](#9-visit-local_domain_name-on-browser) to start Magento 2 installation**.
##### 4. Import database:
```
docker exec -i db mysql -uroot -ppassword magento2 < database.sql
```
##### 5. Replace username/password in `app/etc/env.php` with:
```
root/password (recommended)
magento2/magento2 (having resource limit issue, will be fix in the next release)
```
##### 6. Install dependencies (if needed):

Enter the `app` container to run any command without `docker exec -i app` prefix.
```
docker exec -it app bash
```
Run the installation:
```
composer install
```
Check magento command is working or not:
```
bin/magento --help
```
##### 7. Add your [local_domain_name] (magento2.local for example) into `hosts` file.
```
127.0.0.1	magento2.local
::1             magento2.local
```
##### 8. Set [local_domain_name] for your local site:
```
docker exec -i app bin/magento config:set web/unsecure/base_url http://[local_domain_name]/
docker exec -i app bin/magento config:set web/unsecure/base_link_url http://[local_domain_name]/
docker exec -i app bin/magento config:set web/secure/base_url https://[local_domain_name]/
docker exec -i app bin/magento config:set web/secure/base_link_url https://[local_domain_name]/
```
##### 9. All done! You can now visit your [local_domain_name] or http://localhost on browser.

## Usage

##### Stop containers:
```
docker-compose stop
```
##### Start containers with system-startup:
Modify `.env`, replace `RESTART_CONDITION=no` with `RESTART_CONDITION=always`.

##### Run bin/magento commands:
```
docker exec -i app bin/composer [parameters]
```
or
```
docker exec -it app bash
bin/composer [parameters]
```

##### Applies the changes after modify PHP/MySQL/Nginx config:
```
docker-compose down
docker-compose up -d
```

##### Environment Variables
All the common variables are in `.env`:
```dotenv
# default: app
APP_NAME=app

# ref https://hub.docker.com/_/mysql?tab=tags
MYSQL_IMAGE=mysql:5.7
# ref https://hub.docker.com/_/php?tab=tags
PHPFPM_IMAGE=php:7.2-fpm

# match the container's user with your current user to prevent permission issue
# run this command to know your UID: echo $UID
# default: 1000
USER_ID=1000

# no, on-failure, always or unless-stopped
# ref https://docs.docker.com/config/containers/start-containers-automatically/
RESTART_CONDITION=no

# working directory
# default: ./src
WORKING_DIR=./src

MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=magento2
MYSQL_USER=magento2
MYSQL_PASSWORD=magento2

HTTP_PORT=80
HTTPS_PORT=443
MYSQL_PORT=3306
PHPMYADMIN_PORT=8080
```

##### Useful File Locations

* `src` - your project root directory that contains `composer.json`.
* `m2dd/local.ini` - PHP configuration file.
* `m2dd/my.cnf` - MySQL configuration file.
* `m2dd/conf.d/` - Contains nginx configuration files.
* `m2dd/ssl/` - Contains SSL certs.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

This project is using [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/your/repository/tags). 

## Authors

* **Jared Chu** - *Initial work* - [Resume](https://cv.jaredchu.com/)

See also the list of [contributors](https://github.com/jaredchu/Magento2-Docker-Development/contributors) who 
participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
