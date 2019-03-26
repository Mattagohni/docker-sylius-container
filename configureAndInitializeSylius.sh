#!/usr/bin/env bash

if [ -z "${PROJECT_HOME}" ]; then
    echo "$$PROJECT_HOME must be set!"
    exit 1
fi

if [ -z "${DB_HOST}" ]; then
    DB_HOST=mysql
fi

if [ -z "${DB_PORT}" ]; then
    DB_PORT=3306
fi

if [ -z "${DB_USERNAME}" ]; then
    DB_USERNAME=root
fi

if [ -z "${DB_PASSWORD}" ]; then
    DB_PASSWORD=root
fi

if [ -z "${DB_DATABASE}" ]; then
    DB_DATABASE=test
fi

if [ -z "${WEB_HOST}" ]; then
    WEB_HOST=localhost
fi

CONFIG_FILE=${PROJECT_HOME}/.env

cd ${PROJECT_HOME}

#if [ -z "${FORCE_INSTALL}" ] && [ -f recovery/install/data/install.lock ]; then
#    echo "Installation already done! Skipping!"
#else
echo "Waiting for mysql!"
sleep 15
echo "Create database"
mysql -u${DB_USERNAME} -p${DB_PASSWORD} -h${DB_HOST} -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE}";

echo "Writing config"

# DATABASE_URL=mysql://root@127.0.0.1/sylius_%kernel.environment%
printf '%s\n' ",s~'DATABASE_URL=.*'~'DATABASE_URL='${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'~g" w q | ed -s "${CONFIG_FILE}"
#printf '%s\n' ",s~'port' => '.*'~'port' => '${DB_PORT}'~g" w q | ed -s "${CONFIG_FILE}"
#printf '%s\n' ",s~'username' => '.*'~'username' => '${DB_USERNAME}'~g" w q | ed -s "${CONFIG_FILE}"
#printf '%s\n' ",s~'password' => '.*'~'password' => '${DB_PASSWORD}'~g" w q | ed -s "${CONFIG_FILE}"
#printf '%s\n' ",s~'dbname' => '.*'~'dbname' => '${DB_DATABASE}'~g" w q | ed -s "${CONFIG_FILE}"

echo "Initialize Sylius"

# install shopware including database
#php recovery/install/index.php \
#    --no-interaction \
#    --quiet \
#    --no-skip-import \
#    --db-host="${DB_HOST}" \
#    --db-user="${DB_USERNAME}" \
#    --db-password="${DB_PASSWORD}" \
#    --db-name="${DB_DATABASE}" \
#    --shop-locale="de_DE" \
#    --shop-host="${WEB_HOST}" \
#    --shop-name="Testshop" \
#    --shop-email="sdadmin@sd.test" \
#    --shop-currency="EUR" \
#    --admin-username="sdadmin" \
#    --admin-password="sdadmin" \
#    --admin-email="sdadmin@sd.test" \
#    --admin-name="sdadmin" \
#    --admin-locale="de_DE"
#RECOVERY_INSTALL_RESULT=$?
#echo "Exit code for recovery/install: ${RECOVERY_INSTALL_RESULT}"
#fi

chown -R www-data:www-data ${PROJECT_HOME}/

echo "Starting php-fpm in foreground"
exec /usr/local/bin/docker-php-entrypoint $@
