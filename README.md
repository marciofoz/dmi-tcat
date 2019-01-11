# dmi-tcat

Initial container version for testing purposes.

Please check https://github.com/digitalmethodsinitiative/dmi-tcat/wiki for further information.


Create:
```sh
docker build --no-cache -f Dockerfile -t dmi_tcat .
```


Run:
```sh
docker run -d --restart="always" --name container_name gasparzinho/dmi_tcat
```

Container parameters:

| Parameter | Use |
|-----------|-----|
| ADMIN_USER | Admin username for login |
| ADMIN_PASSWORD | Admin password | 
| USER | User username for login |
| USER_PASSWORD | User password |
| SERVERNAME | Servername |
| DB_HOST | Database host |
| DB_DATABASE | Database name |
| DB_PASSWORD | Database password |
| USERTOKEN | Twitter user token |
| USERSECRET | Twitter user password |
| CONSUMERKEY | Twitter consumer key |
| CONSUMERSECRET | Twitter consumer password |
| ENABLE_URL_EXPANDER | True/False to enable URL_EXPANDER |
| TZ | Timezone (used in php.ini and container timezone) |
