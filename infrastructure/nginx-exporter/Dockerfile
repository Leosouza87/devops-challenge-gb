FROM nginx/nginx-prometheus-exporter:0.9.0

EXPOSE 9113
CMD ["-nginx.scrape-uri", "http://nginx:80/nginx_status"]