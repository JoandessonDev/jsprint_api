FROM ruby:3.3

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia Gemfile primeiro (melhor cache)
COPY Gemfile Gemfile.lock ./

RUN bundle install

# Copia o restante da aplicação
COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]