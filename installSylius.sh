#!/usr/bin/env bash

declare -A KNOWNVERSIONS=(
    [1.1.17]=https://github.com/Sylius/Sylius/archive/v1.1.17.zip
    [1.2.16]=https://github.com/Sylius/Sylius/archive/v1.2.16.zip
    [1.3.9]=https://github.com/Sylius/Sylius/archive/v1.3.9.zip
    [1.4.1]=https://github.com/Sylius/Sylius/archive/v1.4.1.zip
)

if [ -z "${KNOWNVERSIONS[$SYLIUS_VERSION]}" ]; then
    echo "This script does not know how to get sylius ${SYLIUS_VERSION}"
    echo "Please create a pull request at 'https://github.com/mattagohni/docker-sylius-container' and"
    echo "provide an url to get the requested version!"
    exit 1
fi
SYLIUS_URL=${KNOWNVERSIONS[$SYLIUS_VERSION]}

if [ -z "${PROJECT_HOME}" ]; then
    echo "$$PROJECT_HOME must be set!"
    exit 1
fi

mkdir -p ${PROJECT_HOME}

echo "Everything is configured, starting setup:"
echo "PHP_VERSION: ${PHP_VERSION}"
echo "SYLIUS_VERSION: ${SYLIUS_VERSION}"
echo "SYLIUS_URL: ${SYLIUS_URL}"
echo "PROJECT_HOME: ${PROJECT_HOME}"

cd ${PROJECT_HOME}

echo "Downloading sylius"
wget -q -O install.zip "${SYLIUS_URL}"

echo "Unzipping install.zip"
unzip -q install.zip


mv ${PROJECT_HOME}/Sylius-${SYLIUS_VERSION}/* ${PROJECT_HOME}
rm -rf ${PROJECT_HOME}/Sylius-${SYLIUS_VERSION}/

php -dmemory_limit=-1 /usr/local/bin/composer install --no-dev -o --no-scripts

chown -R www-data:www-data ${PROJECT_HOME}/
