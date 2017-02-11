# alpine-apache-php

This image is currently under development and changing rapidly, so don't use it for anything other than an example.
What does generally work is the combination of alpine-apache-php7 (which didn't initially play nice).
I have also integrated the new php7-mongodb module, which is why the base Alpine iage is Edge vs. Latest.
Note that php7-mongodb is currently part of the Alpine "test" repository, so I'm not sure how stable it is at this point.  I know it doesn't immediately cause anything to error out and I have done some initial testing, but I sure wouldn't trust any real data to it at this point.

<h1>***** The real purpose of this repository is a working image for an application called Twilio Voice Manager (TVM).</h1>

exports port 80 only under the assumption a proxy (e.g. Nginx, Caddy, etc.) would be used if SSL is needed.
(TBD - Expose 443 or not based on ENV variable)

Optional volumes to map:

a) Location for custom pre-init and pre-exec scripts.
   Container path: /scripts
   Local path:<myscripts-dir>
   
   Place your pre-init scripts in <myscripts-dir>/pre-init.d
   Place your pre-exec scripts in <myscripts-dir>/pre-exec.d
   
   Script files names must end in .sh
   
   *** Dockerfile BUG ********** For some reason the run.sh isn't being copied into the scripts directory when mapped,
   so if you're mapping to a local volume, you should manually create the run.sh file (see GitHub repository as example).
   
b) Apache app directory
   Container path: /app
   Local path: <myapp-dir>
   
(TBD - Use ENV variable to define /app path)
