#!/bin/bash

chown www-data:www-data $MAGENTO_ROOT

[ ! -z "${COMPOSER_MAGENTO_USERNAME}" ] && \
    composer config --global http-basic.repo.magento.com \
        $COMPOSER_MAGENTO_USERNAME $COMPOSER_MAGENTO_PASSWORD

if [[ "$AUTO_INSTALL" = "true" ]]; then
  composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.1 $MAGENTO_ROOT

  $MAGENTO_ROOT/bin/magento setup:install \
    --base-url=$BASE_URL \
    --db-host=db \
    --db-name=$MYSQL_DATABASE \
    --db-user=$MYSQL_USER \
    --db-password=$MYSQL_PASSWORD \
    --backend-frontname=backend \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@admin.com \
    --admin-user=admin \
    --admin-password=Admin123$ \
    --language=pl_PL \
    --currency=PLN \
    --timezone=Europe/Warsaw \
    --use-rewrites=1 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200

    $MAGENTO_ROOT/bin/magento setup:di:compile

    chmod -R 777 $MAGENTO_ROOT
fi

exec "$@"