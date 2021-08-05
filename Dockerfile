FROM ruby:2.6

# ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && apt-get update \
    && apt-get -y install vim \
    && mkdir /campfs

WORKDIR /campfs
COPY Gemfile /campfs/Gemfile
COPY Gemfile.lock /campfs/Gemfile.lock
ENV BUNDLER_VERSION 2.1.0
RUN gem update --system \
    && gem install bundler -v $BUNDLER_VERSION \
    && bundle install -j 4
# RUN bundle install
RUN yarn install
COPY . /campfs

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# COPY start.sh /start.sh
# RUN chmod 744 /start.sh
# CMD ["sh", "/start.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]