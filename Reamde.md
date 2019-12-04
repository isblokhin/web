### NGINX
 
Простая защита от DDOS
Написать конфигурацию nginx, которая даёт доступ клиенту только с определенной cookie.
Если у клиента её нет, нужно выполнить редирект на location, в котором кука будет добавлена, после чего клиент будет обратно отправлен (редирект) на запрашиваемый ресурс.

Смысл: умные боты попадаются редко, тупые боты по редиректам с куками два раза не пойдут

Для выполнения ДЗ понадобятся
- https://nginx.org/ru/docs/http/ngx_http_rewrite_module.html
- https://nginx.org/ru/docs/http/ngx_http_headers_module.html

[Конфигурация](default.conf) сервера:

<pre> server {
    listen 80;
    server_name localhost;
    index index.html index.htm;
    root /usr/share/nginx/html;
    access_log /var/log/nginx/host.access.log main;
    location / {
      if (<span style="color:red"><b>$cookie_id != "123"</b></span>) {
        return 302 $scheme://$server_addr/setcookie;
      }
    }
    location /setcookie {
      <span style="color:red"><b>add_header Set-Cookie "id=123";</b></span>
      return 302 $scheme://$server_addr$request_uri;
    }
}
</pre>

Если клиент запрашивает location "/" и у клиента не установлено cookie `id=123` 
(проверка `if ($cookie_id != "123")`) то происходит его перенаправление на location 
"/setcookie". Клиент получает cookie – `add_header Set-Cookie "id=123"`, после чего 
происходит перенаправление на location "/". Теперь клиент удовлетворяет условиям 
проверки и получает тестовую страницу nginx.

Используем для этих манипуляций директиву `return` с кодом 302 в контексте `location`. 302-е перенаправление говорит о том, что нужно перейти по другому адресу.

Перенаправления: 
![](https://github.com/isblokhin/web/blob/master/1.png) 
Установленные cookie:
![](https://github.com/isblokhin/web/blob/master/2.png)
