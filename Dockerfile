FROM nginx
COPY --from=phntom/mattermost-team-edition:6.4.0 /mattermost/client/ /usr/share/nginx/html/static/
COPY default.conf /etc/nginx/conf.d/default.conf
COPY static /usr/share/nginx/html/static/
COPY api /usr/share/nginx/html/api/
RUN sed -i"" 's#<noscript>#<script src="/static/announcement.js" data-id="137058" async="async" type="text/javascript"></script><noscript>#g' /usr/share/nginx/html/static/root.html
RUN nginx -t && \
  /etc/init.d/nginx start && \
  cd /usr/share/nginx/html/static/ && \
  curl -v "http://localhost/static/`find . -name 'main.*.js' | tail -n1 | cut -f2 -d'/'`" 2>&1 | grep -q "Content-Type: application/javascript" && \
  curl -v "http://localhost/static/`find . -name 'main.*.css' | tail -n1 | cut -f2 -d'/'`" 2>&1 | grep -q "Content-Type: text/css" && \
  /etc/init.d/nginx stop
