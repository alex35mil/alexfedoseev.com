FROM nginx:1.19

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx.ssl.conf /etc/nginx/nginx.ssl.conf

COPY ./certs/alexfedoseev.dev.pem /etc/ssl/certs/
COPY ./certs/alexfedoseev.dev.key /etc/ssl/private/

CMD ["nginx", "-g", "daemon off;"]
