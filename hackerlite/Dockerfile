# Set nginx base image
FROM nginx

# File Author / Maintainer
LABEL AUTHOR="Blair Garrett<blair.garrett1@gmail.com>"

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY sslcerts/dhparam.pem /etc/ssl/certs/dhparam.pem

RUN mkdir -p /etc/letsencrypt/live/hackerlite.xyz && \
    mkdir -p /home/www-data/hackerlite.xyz/static/js && \
    mkdir -p /home/www-data/hackerlite.xyz/static/images && \
    mkdir -p /home/www-data/hackerlite.xyz/static/html

# Copy SSL keys/certs
COPY sslcerts/fullchain.pem /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem
COPY sslcerts/privkey.pem /etc/letsencrypt/live/hackerlite.xyz/privkey.pem

# Service worker
COPY themes/casper/sw-toolbox.js /home/www-data/hackerlite.xyz/static/js/sw-toolbox.js
COPY themes/casper/serviceworker-v1.js /home/www-data/hackerlite.xyz/static/js/serviceworker-v1.js
COPY themes/casper/manifest.webmanifest /home/www-data/hackerlite.xyz/static/js/manifest.webmanifest
COPY themes/casper/sw.html /home/www-data/hackerlite.xyz/static/html/sw.html

# PWA images
COPY themes/casper/images/ /home/www-data/hackerlite.xyz/static/images/