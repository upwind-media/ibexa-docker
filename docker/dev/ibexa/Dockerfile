FROM sklimaszewski/php-symfony:8.1-fpm-mysql

ENV XDEBUG_ENABLED=0

WORKDIR /var/www/html/project/ibexa

COPY entrypoint.bash /entrypoint.bash
RUN chmod +x /entrypoint.bash

ENTRYPOINT ["/entrypoint.bash"]
CMD ["php-fpm"]