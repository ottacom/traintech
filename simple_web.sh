docker rm -f special_effects
docker run -it --name special_effects -p 8123:80 -v /tmp:/usr/local/apache2/htdocs/ --restart unless-stopped httpd
