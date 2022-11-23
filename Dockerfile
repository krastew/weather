FROM ubuntu

COPY weather.sh /opt/weather/weather.sh

RUN chmod +x /opt/weather/weather.sh

RUN apt-get update && apt-get install -y curl \
                                         jq \
                                         bc

CMD ["/opt/weather/weather.sh"]

