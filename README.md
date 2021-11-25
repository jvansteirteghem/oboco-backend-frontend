# oboco-backend-frontend

## requirements

- docker

## configuration

- docker-compose.yml
	- services.oboco-backend-database.environment
		- TZ: the timezone
		- MYSQL_ROOT_PASSWORD: the database user password
		- MYSQL_DATABASE: the database name
	- services.oboco-backend.environment
		- TZ: the timezone
		- OBOCO_SECURITY_AUTHENTICATION_SECRET: the authentication secret
		- OBOCO_DATABASE_URL: the database url
		- OBOCO_DATABASE_USER_NAME: the database user name
		- OBOCO_DATABASE_USER_PASSWORD: the database user password
	- services.oboco-backend.volumes
		- /application-logger-data: the logger data
		- /application-data: the data (book pages)
		- /user-data: the data (books, book collections)
	- services.oboco-frontend.environment
		- TZ: the timezone

## run

- start
	- docker-compose up (-d)
	- when database is ready (mariadbd: ready for connections.), open http://127.0.0.1
	- log in
		- name: administrator
		- password: administrator
- stop
	- docker-compose down

## license

- mit license
- [pepper and carrot](https://www.peppercarrot.com/): by david revoy and contributors, licensed under [creative commons attribution 4.0](https://creativecommons.org/licenses/by/4.0/)