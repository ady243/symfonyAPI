FROM postgres:latest

LABEL author="Bastien & Ady"
LABEL description="Postgres Custom Image"
LABEL version="1.0"

# Upgrade existing packages in the base image
RUN apk --no-cache upgrade

# Install apache from packages with out caching install files
RUN apk add --no-cache apache2

# Creat directory for apache2 to store PID file
RUN mkdir /run/apache2

# Start apache2
RUN service apache2 start

# Install Adminer and enable apache2 configuration
RUN apk add --no-cache adminer \
&& apk add --no-cache a2enconf adminer \
&& service apache2 restart

EXPOSE 8081


