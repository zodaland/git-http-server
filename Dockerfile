FROM alpine:latest

EXPOSE 80

VOLUME ["/git"]

# We need the following:
# - git-daemon, because that gets us the git-http-backend CGI script
# - fcgiwrap, because that is how nginx does CGI
# - spawn-fcgi, to launch fcgiwrap and to create the unix socket
# - nginx, because it is our frontend
RUN apk add --update nginx && \
    apk add --update git-daemon && \
    apk add --update fcgiwrap && \
    apk add --update spawn-fcgi && \
    rm -rf /var/cache/apk/*

COPY ./git-server/nginx.conf /etc/nginx/nginx.conf
COPY ./git-server/.htpasswd /etc/nginx/.htpasswd

# launch fcgiwrap via spawn-fcgi; launch nginx in the foreground
# so the container doesn't die on us; supposedly we should be
# using supervisord or something like that instead, but this
# will do
CMD spawn-fcgi -s /run/fcgi.sock /usr/bin/fcgiwrap && \
    nginx -g "daemon off;"
