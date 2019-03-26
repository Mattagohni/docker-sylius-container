#!/usr/bin/env bash

set -e

docker build \
    --build-arg PHP_VERSION=$PHP_VERSION \
    --build-arg PHP_SHORT_VERSION=$PHP_SHORT_VERSION \
    --build-arg SYLIUS_VERSION=$SYLIUS_VERSION \
    --build-arg SYLIUS_SHORT_VERSION=$SYLIUS_SHORT_VERSION \
    -t mattagohni/docker-sylius-container:sylius$SYLIUS_VERSION-php$PHP_VERSION \
    .

# Tag "latest"
if [ "$LATEST" = "1" ]; then
    docker tag \
        mattagohni/docker-sylius-container:sylius$SYLIUS_VERSION-php$PHP_VERSION \
        mattagohni/docker-sylius-container:latest
fi
