FROM nginx
COPY --from=phntom/mattermost-team-edition:5.36.0 /mattermost/client/ /usr/share/nginx/html/static/
COPY default.conf /etc/nginx/conf.d/default.conf
COPY static /usr/share/nginx/html/static/
COPY api /usr/share/nginx/html/api/
