FROM httpd:2.4

COPY index.html /usr/local/apache2/htdocs/
COPY metadata.sh /usr/local/apache2/htdocs/
COPY font /usr/local/apache2/htdocs/font
COPY images /usr/local/apache2/htdocs/images
RUN chmod +x /usr/local/apache2/htdocs/metadata.sh

EXPOSE 80
WORKDIR /usr/local/apache2/htdocs/
CMD ./metadata.sh && apachectl -D FOREGROUND