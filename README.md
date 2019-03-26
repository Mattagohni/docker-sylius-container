# docker-sylius-container

Docker container with installed sylius highly inspired by 
[solutiondrive/docker-shopware-container](https://github.com/solutionDrive/docker-shopware-container)

## Environment variables

There are some environment variables which should be available during startup:

    DB_DATABASE

This variable defines for which database this sylius installation should be configured. (default: test)
It is important to use different databases per sylius container.

    WEB_HOST

This variable will be used to initialize the shop for the correct url. (default: localhost)
It is important to use different hosts per sylius container.


Also the following environment variables will be considered during startup:

    DB_HOST

Host on which your database is running. (default: mysql)

    DB_PORT

Port on which your database is listening. (default: 3306)

    DB_USERNAME

Username which will be used to connect to your database. (default: root)

    DB_PASSWORD

Password which will be used to connect to your database. (default: root)

## License

See LICENSE file
