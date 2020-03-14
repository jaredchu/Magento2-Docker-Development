# Magento2 Docker Development
Simple, fast and easy way to develop Magento 2 on localhost

## Why
- Running Magento 2 project really fast on your machine.
- Just a few steps to stup.
- No extra step to deploy code from host to container.
- Easy to modify PHP, MySQL and Nginx configurations.
- Works on Linux, MacOS and Windows.

## Prerequisities
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
cd [project_name]
rm -rf .git
```
##### 2. Copy your project's code into `src` folder.
##### 3. Run the containers:
```
docker-compose up -d
```
If this is a new project then you can now **jump to [step 9](#9-visit-local_domain_name-on-browser) to start Magento 2 installation**.
##### 4. Import database:
```
docker exec -i db mysql -uroot -ppassword magento2 < database.sql
```
##### 5. Modify `app/etc/env.php` database username/password with:
```
root/password (recommended)
magento2/magento2 (having resource limit issue, will be fix in the next release)
```
##### 6. Add your [local_domain_name] (magento2.local for example) into `hosts` file.
##### 7. Set [local_domain_name] for your local site:
```
docker exec -i app bin/magento config:set web/unsecure/base_url [local_domain_name]
docker exec -i app bin/magento config:set web/unsecure/base_link_url [local_domain_name]
docker exec -i app bin/magento config:set web/secure/base_url [local_domain_name]
docker exec -i app bin/magento config:set web/secure/base_link_url [local_domain_name]
```
##### 8. Install dependencies (if needed):

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
##### 9. Visit [local_domain_name] on browser.

## Usage

#### Stop containers:
```
docker-compose stop
```
#### Start containers with system-startup:
Modify `docker-compose.yml`, replace `on-failure` with `always`.

#### Run bin/magento commands:
```
docker exec -i app bin/composer [parameters]
```
or
```
docker exec -it app bash
bin/composer [parameters]
```

#### Applies the changes after modify PHP/MySQL/Nginx config:
```
docker-compose down
docker-compose up -d
```

#### Environment Variables
```yaml
MYSQL_ROOT_PASSWORD: password
MYSQL_DATABASE: magento2
MYSQL_USER: magento2
MYSQL_PASSWORD: magento2
SERVICE_TAGS: dev
SERVICE_NAME: mysql
```

#### Useful File Locations

* `src` - your project root directory that contains `composer.json`.
* `m2dd/local.ini` - PHP configuration file.
* `m2dd/my.cnf` - MySQL configuration file.
* `m2dd/conf.d/` - Contains nginx configuration files.
* `/m2dd/ssl/` - Contains SSL certs.

## Docker images in use
* php:7.2-fpm
* mysql:5.7.22
* nginx:alpine

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

This project is using [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/your/repository/tags). 

## Authors

* **Jared Chu** - *Initial work* - [CV](https://cv.jaredchu.com/)

See also the list of [contributors](https://github.com/jaredchu/Magento2-Docker-Development/contributors) who 
participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
