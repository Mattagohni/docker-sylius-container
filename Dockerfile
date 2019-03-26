ARG PHP_VERSION

FROM solutiondrive/docker-php-container:php$PHP_VERSION


# Make it usable after FROM
ARG SYLIUS_VERSION
ARG SYLIUS_SHORT_VERSION
ARG PHP_SHORT_VERSION
ENV SYLIUS_VERSION $SYLIUS_VERSION
ENV PROJECT_HOME /var/www/sylius${SYLIUS_SHORT_VERSION}_php${PHP_SHORT_VERSION}

ADD installComposer.sh /bin/installComposer.sh
RUN chmod +x /bin/installComposer.sh \
    && sync \
    && /bin/installComposer.sh


ADD installSylius.sh /bin/installSylius.sh
RUN chmod +x /bin/installSylius.sh \
    && sync \
    && /bin/installSylius.sh

COPY configureAndInitializeSylius.sh /bin/configureAndInitializeSylius.sh

ENTRYPOINT ["/bin/configureAndInitializeSylius.sh"]
CMD ["php-fpm"]


#TZ=Europe/Berlin
 #      - DB_DATABASE=shopware53_php71
 #      - WEB_HOST=localhost:53871