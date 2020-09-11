![Magento2 Docker Development](https://i.imgur.com/tm852O1.jpg)
[![Magento2 Docker Development](https://i.imgur.com/3N3tOmys.jpg)](https://i.imgur.com/3N3tOmy.jpg)
[![Magento2 Docker Development](https://i.imgur.com/qOfWAy7s.jpg)](https://i.imgur.com/qOfWAy7.jpg)
[![Magento2 Docker Development](https://i.imgur.com/ui4qXVzs.jpg)](https://i.imgur.com/ui4qXVz.jpg)
[![Magento2 Docker Development](https://i.imgur.com/FVPYIXms.jpg)](https://i.imgur.com/FVPYIXm.jpg)

## Why
- Running Magento 2 project really fast on your machine.
- Just a few steps to setup.
- No extra step to deploy code from host to container.
- Easy to modify PHP, MySQL, and Nginx configurations.
- Works on Linux, macOS, and Windows.

## Default Official Images
* php:7.2-fpm
* mysql:5.7
* nginx:1.19

## Prerequisities
**All OS**: Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

**Linux:**
Install [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

**MacOS:**
Install [Docker](https://docs.docker.com/docker-for-mac/install/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

**Windows:**
Install [Docker](https://docs.docker.com/docker-for-windows/install/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

## Quick Start (new project)
##### 1. Clone the project:
```
git clone https://github.com/jaredchu/Magento2-Docker-Development.git [project_name]
cd [project_name]
```
##### 2. Update `m2dd/auth.json` and fill its data with your credentials.
- [How to get Magento authentication keys](https://devdocs.magento.com/guides/v2.4/install-gde/prereq/connect-auth.html)
- [How to get Github personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
##### 3. Run container & Get latest Magento 2 source code
```
docker-compose up -d
docker exec -it app bash -c "rm .gitkeep && composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition:2.3 . --prefer-dist --no-interaction --dev"
```
##### 4. Restart containers
```
docker-compose down
docker-compose up -d
```
You can now start to install your new Magento 2 site via [Web Setup Wizard](https://docs.magento.com/user-guide/v2.3/system/web-setup-wizard.html) (will be removed in Magento 2.4) or [Command Line](https://devdocs.magento.com/guides/v2.3/install-gde/install/cli/install-cli.html) (recommended).

## Existing Project

##### 1. Clone the project:
```
git clone https://github.com/jaredchu/Magento2-Docker-Development.git [project_name]
cd [project_name]
```
##### 2. Copy your magento 2 source code into `src` folder.
##### 3. Run the containers:
```
docker-compose up -d
```
##### 4. Import database:
```
docker exec -i db mysql -uroot -ppassword magento2 < your-database.sql
```
##### 5. Modify the DB cofiguration in `app/etc/env.php`:
```
'db' => [
    'table_prefix' => '',
    'connection' => [
        'default' => [
            'host' => 'db',
            'dbname' => 'm2db',
            'username' => 'm2user',
            'password' => 'm2pw',
            'active' => '1',
            'driver_options' => [
            ]
        ]
    ]
],
```
##### 6. Install dependencies:

Enter the `app` container TTY (to run any command without `docker exec -i app` prefix).
```
docker exec -it app bash
```
Run the composer installation:
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
docker exec -i app bin/magento config:set web/unsecure/base_url http://magento2.local/
docker exec -i app bin/magento config:set web/unsecure/base_link_url http://magento2.local/
docker exec -i app bin/magento config:set web/secure/base_url https://magento2.local/
docker exec -i app bin/magento config:set web/secure/base_link_url https://magento2.local/
```
##### 9. All done! Visit your [local_domain_name] (http://magento2.local for example) on your browser.

## Usage

##### Restart containers (required when you want to apply the changes after modify `.env` or `docker-composer.yml`):
```
docker-compose down
docker-compose up -d
```
##### Start containers with system-startup:
Modify `.env`, replace `RESTART_CONDITION=no` with `RESTART_CONDITION=always`.

##### Run bin/magento commands:
```
docker exec -i app bin/magento [parameters]
```
or
```
docker exec -it app bash
bin/magento [parameters]
```

##### Environment Variables
All the common variables are in `.env`.

##### Useful File Locations

* `src` - your project root directory that contains `composer.json` and `app` folder.
* `m2dd/local.ini` - PHP configuration file.
* `m2dd/my.cnf` - MySQL configuration file.
* `m2dd/auth.json` - Composer basic auth file.
* `m2dd/conf.d/` - Contains nginx configuration files.
* `m2dd/ssl/` - Contains SSL certs.
* `m2dd/crontabs/root` - Crontab for root user.
* `m2dd/crontabs/www` - Crontab for www user.

## Contributing

Feel free for submitting pull requests to this project.

## Versioning

This project is using [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/jaredchu/Magento2-Docker-Development/tags). 

## Authors

* **Jared Chu** - *Initial work* - [About Jared](https://cv.jaredchu.com/)

See also the list of [contributors](https://github.com/jaredchu/Magento2-Docker-Development/contributors) who 
participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
