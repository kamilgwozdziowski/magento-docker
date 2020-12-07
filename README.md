# Ogólne
**Wersja PHP:** 7.3 \
**Wersja Nginx:** 1.11 \
**Wersja OS:** Ubuntu 20.04.1\
**Wersja Elastic Search:** 7.8.1\
**Varnish:** 6.2

# Zawartość obrazu
### Moduły PHP:
bcmath, calendar, Core, ctype, curl, date, dom, exif, FFI, fileinfo, 
filter, ftp, gd, gettext, hash, iconv, intl, json, libxml, mbstring, 
mysqli, mysqlnd, openssl, pcntl, pcre, PDO, pdo_mysql, Phar, posix, 
readline, Reflection, session, shmop, SimpleXML, soap, sockets, 
sodium, SPL, standard, sysvmsg, sysvsem, sysvshm, tokenizer, 
xdebug, xml, xmlreader, xmlwriter, xsl, Zend OPcache, zip, zlib, Xdebug, Zend OPcache, 

# Używanie obrazu:
### Zmienne środowiskowe 

- `PROJECT_NAME` - nazwa projektu 

- `BASE_URL` - URL pod jakim ma znajdować się Magento 

- `MYSQL_ROOT_PASSWORD` - hasło administratora MySQL

- `MYSQL_USER` - nazwa użytkownika MySQL

- `MYSQL_PASSWORD` - hasło użytkownika MySQL

- `MYSQL_DATABASE` - nazwa bazy danych MySQL

- `COMPOSER_MAGENTO_USERNAME` - public key z Magento marketplace

- `COMPOSER_MAGENTO_PASSWORD` - public private z Magento marketplace

# Instalacja środowiska Magento 2
### Instalacja podstawowa:
Należy zmienić nazwę pliku .env.example na .env i uzupełnić wszystkie zmienne środowiskowe.
Teraz uruchamiamy komendę:
```
docker-compose up -d
```

Łączymy się z kontenerem PHP

```
docker exec -it ${PROJECT_NAME}_php bash
```

Wykonujemy polecenia
```shell
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.1 /var/www/html

/var/www/html/bin/magento setup:install --base-url=${BASE_URL} --db-host=db --db-name=${MYSQL_DATABASE} --db-user=${MYSQL_USER} --db-password=${MYSQL_PASSWORD} --backend-frontname=backend --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password=Admin123$ --language=pl_PL --currency=PLN --timezone=Europe/Warsaw --use-rewrites=1 --elasticsearch-host=elasticsearch --elasticsearch-port=9200
/var/www/html/bin/magento setup:di:compile

find /var/www/html -type f -exec chmod 644 {} \; 
find /var/www/html -type d -exec chmod 755 {} \;    
find /var/www/html/var -type d -exec chmod 777 {} \;                    
find /var/www/html/pub/media -type d -exec chmod 777 {} \;
find /var/www/html/pub/static -type d -exec chmod 777 {} \;
chmod 777 /var/www/html/app/etc
chmod 644 /var/www/html/app/etc/*.xml
chown -R :www-data /var/www/html
chmod u+x /var/www/html/bin/magento
```

Następnie należy wyedytować plik host wskazujący na domenę np:
```
127.0.0.1   ${BASE_URL}
127.0.0.1   www.${BASE_URL}
```
W przeglądarce uruchamiany adres wpisany
### Opcjonalne: Instalacja przykładowych danych:
Aby zainstalować przykładowe dane do Magento 2 należy wpierw wejść w kontener za pomocą komendy:
```
docker exec -it ${PROJECT_NAME}_php bash
```
i uruchomić te polecenia:
```
bin/magento sampledata:deploy
bin/magento setup:upgrade
bin/magento indexer:reindex
bin/magento cache:flush
```

# Informacje dodatkowe #
Jeśli chcemy zalogować się do backend należy wejść w URL:
```
${BASE_URL}/backend
```
Dane do logowania:
```
login: admin
hasło Admin123$
```