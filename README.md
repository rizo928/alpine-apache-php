# alpine-apache-php

<h1>Currently under development and changing rapidly.</h1>

What does generally work is the combination of alpine-apache-php7 (which didn't initially play nice).

Exports port 80 only under the assumption a proxy (e.g. Nginx, Caddy, etc.) would be used if SSL is needed.
(TBD - Expose 443 or not based on ENV variable)

Volumes that should be mapped include:

a) Apache app directory
   Container path: /app
   Local path: <myapp-dir>
   (TBD - Use ENV variable to define /app path)

b) Location for custom pre-init and pre-exec scripts.
   Container path: /scripts
   Local path:<myscripts-dir>
   
   Place any custom scripts you would like to run in this directory.  They will be executed prior to starting Apache.
   
   Script files names must end in .sh
   
   The main executable (/run.sh) will search in /scripts for any file ending in .sh
   It will then attempt to execute the scripts it finds when the container is brough online.  This is useful
   for instance specific stuff like configuring httpd.conf to contain the correct ServerName etc.

c) SSMTP directory (optional)
   Container path: /etc/ssmtp
   Local path:<myssmtp-dir>
   
   ssmtp configuration files including: revaliases  and  ssmtp.conf
   
   See ssmtp documentation for details re: the format of these files.
   
   If you don't care about having email working within the container, then
   simply skip mapping this and move on.
   
   

