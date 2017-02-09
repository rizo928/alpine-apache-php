# alpine-apache-php

based on latest version of alpine linux

exports port 80 only under the assumption a proxy (e.g. Nginx, Caddy, etc.) would be used if SSL is needed.
(TBD - Expose 443 or not based on ENV variable)

Optional volumes to map:

a) Location for custom pre-init and pre-exec scripts.
   Container path: /scripts
   Local path:<myscripts-dir>
   
   Place your pre-init scripts in <myscripts-dir>/pre-init.d
   Place your pre-exec scripts in <myscripts-dir>/pre-exec.d
   
   Script files names must end in .sh
   
b) Apache app directory
   Container path: /app
   Local path: <myapp-dir>
   
(TBD - Use ENV variable to define /app path)
