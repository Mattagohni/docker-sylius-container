#!/usr/bin/env bash

set -e

ATTRIBUTES_TEMPLATE_FILE="tests/inspec/sylius-container/attributes.yml.template"
ATTRIBUTES_FILE="tests/inspec/sylius-container/attributes.yml"
cp ${ATTRIBUTES_TEMPLATE_FILE} ${ATTRIBUTES_FILE}
printf '%s\n' ",s~{{ sylius_short_version }}~${SYLIUS_SHORT_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"
printf '%s\n' ",s~{{ php_short_version }}~${PHP_SHORT_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"

DOCKER_CONTAINER_ID=`docker run -d mattagohni/docker-sylius-container:sylius$SYLIUS_VERSION-php$PHP_VERSION`
bundle exec inspec exec tests/inspec/sylius-container --attrs tests/inspec/sylius-container/attributes.yml -t docker://${DOCKER_CONTAINER_ID}
docker stop ${DOCKER_CONTAINER_ID}
