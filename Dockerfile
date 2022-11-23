FROM ubuntu

COPY weather.sh ~/weather/

RUN chmod +x weather.sh

CMD ["/bin/bash ./weather.sh"]