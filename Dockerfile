FROM nginx:alpine 
COPY default.conf /etc/nginx/conf.d/default.conf 
COPY otus.txt /opt/otus.txt 
CMD ["nginx","-g","daemon off;"]
