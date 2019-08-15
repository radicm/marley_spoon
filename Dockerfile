FROM ruby:2.5.3

RUN apt-get update

COPY . /app

WORKDIR /app

RUN bundle

CMD ["./docker/start.sh"]
