vcl 4.0;

import std;

#backend default {
#    .host = "web";
#    .port = "8080";
#}

backend default {
    .host = "web222";
    .port = "8080";
    .first_byte_timeout = 600s;
}