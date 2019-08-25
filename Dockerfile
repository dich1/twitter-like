FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs apt-transport-https git less vim tig graphviz xsltproc xvfb wkhtmltopdf fonts-ipafont default-mysql-client xpdf
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn
RUN mkdir /twitter-like
WORKDIR /twitter-like
COPY Gemfile /twitter-like/Gemfile
COPY Gemfile.lock /twitter-like/Gemfile.lock
RUN bundle install
COPY . /twitter-like

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

EXPOSE 3000
CMD RAILS_ENV=${RAILS_ENV} bundle exec pumactl start

