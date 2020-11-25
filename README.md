# Ogólne
**Wersja PHP:** 7.3 \
**Wersja Nginx:** 1.11 \
**Wersja OS:** Ubuntu 20.04.1\
**Wersja Elastic Search:** 7.8.1

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

- `AUTO_INSTALL` - jeśli ta wartość jest true to instalujemy nowa instacje magento, jeśli chcemy korzystać z projektu który już istnieje należy dodac dump bazy danych do **./db/sql**

# Instalacja środowiska Magento 2
### Instalacja podstawowa:
Należy zmienić nazwę pliku .env.example na .env i uzupełnić wszystkie zmienne środowiskowe.
Teraz uruchamiamy komendę:
```
docker-compose up
```

Jeśli jest ustawiona flaga `AUTO_INSTALL` proces potrwa ok 30 min

Komenda ta instaluje nam wszystkie obrazy i automatycznie uruchamia instalacje Magento 2.
Następnie należy wyedytować plik host wskazujący na domenę np:
```
127.0.0.1   ${BASE_URL}
127.0.0.1   www.${BASE_URL}
```
W przeglądarce uruchamiany adres wpisany
### Opcjonalne: Instalacja przykładowych danych:
Aby zainstalować przykładowe dane do Magento 2 należy wpierw wejść w kontener za pomocą komendy:
```
docker exec -it magento_cli_1 bash
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

Jeśli chcemy zmienić te dane na etapie instalacji należy edytować plik `./cli/docker-entrypoint.sh`
