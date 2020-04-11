### setting up and installing passbolt locally on ubuntu 18.04 using docker.
 - pull passbolt and mariadb image using below command:
 ```sh
 docker pull passbolt/passbolt:latest
 docker pull mariadb
 ```
 
 - create a docker network to which both mysql and passbolt container will belong, this will be passed later to both passbolt and mariadb container.
 ```sh
 docker network create <network_id>
 ```
 
 - create a docker volume and mount it on /var/lib/mysql to make the data persist.
 ```sh
 docker volume create <volume_id>
 ```
 
 - setup and run  mariadb using below configuraiton :
 ```sh
 docker run -d --name mariadb --net <network_id> \
	 --mount source=<volume_id>,target='/var/lib/mysql' \
	 -e MYSQL_ROOT_PASSWORD=<root password> \
	 -e MYSQL_DATABASE=<database name> \
	 -e MYSQL_USER=<database user> \
	 -e MYSQL_PASSWORD=<database password> \
         mariadb
 ```
 
 - setup and run passbolt:
 ```
 docker run --name passbolt -d --net <network_id> \
             -p 443:443 \
             -p 80:80 \
             -e DATASOURCES_DEFAULT_HOST=mariadb \
             -e DATASOURCES_DEFAULT_PASSWORD=<database password> \
             -e DATASOURCES_DEFAULT_USERNAME=<database user> \
             -e DATASOURCES_DEFAULT_DATABASE=<database name> \
             passbolt/passbolt:latest

 ```
 
 - create the first admin using using below command:
 ```sh
 docker exec passbolt su -m -c "/var/www/passbolt/bin/cake \
                                passbolt register_user \
                                -u <your email> \
                                -f <first name> \
                                -l <last name> \
                                -r admin" -s /bin/sh www-data
 ```

