Role Name
=========

Rol para desplegar LAMP:

Linux, el sistema operativo
Apache, el servidor web
MySQL/MariaDB, el gestor de bases de datos
Perl, PHP, o Python, los lenguajes de programación


Requirements
------------

N/A

Role Variables
--------------

El rol acepta las siguientes variables:

- root_mariadb_password: Contraseña que se configurará por defecto en la BBDD

El rol acepta los siguientes tags:

- 00-deploy-httpd.yml 			tags=httpd
- 00-deploy-mariadb.yml 		tags=mariadb
- 00-deploy-php.yml 			tags=php
- 00-deploy-phpMyAdmin.yml 		tags=phpMyAdmin
- 00-deploy-HAproxy-keepalived.yml 	tags=ha

Dependencies
------------

N/A

Example Playbook
----------------

- Despliegue de todo el stack lamp

`ansible-playbook playbooks/deploy_lamp.yml -i inventory/servers --extra-vars "servers=web"`

- Despliegue de toto el stack con HAproxy y keepalived

`ansible-playbook playbooks/deploy_lamp.yml -i inventory/servers --extra-vars "servers=web ha_mode=true"`

- Despliegue de una servicio concreto

`ansible-playbook playbooks/deploy_lamp.yml -i inventory/servers --extra-vars "servers=web" --tags=mariadb -v`

License
-------

BSD

Author Information
------------------

@miquelMariano

30/12/2015
