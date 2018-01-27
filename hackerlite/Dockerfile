# Set nginx base image
FROM nginx

# File Author / Maintainer
LABEL AUTHOR="Blair Garrett<blair.garrett1@gmail.com>"

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY sslcerts/dhparam.pem /etc/ssl/certs/dhparam.pem

RUN mkdir -p /etc/letsencrypt/live/hackerlite.xyz

# Copy SSL keys/certs
COPY sslcerts/fullchain.pem /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem
COPY sslcerts/privkey.pem /etc/letsencrypt/live/hackerlite.xyz/privkey.pem
