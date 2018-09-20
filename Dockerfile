FROM ruby:2.5-alpine

# Install requisite packages for app to run
RUN apk --update --no-cache add nodejs postgresql-dev

# Make and set the working directory
RUN mkdir -p /opt/sir_judgington
WORKDIR /opt/sir_judgington

# Copy the gemfile and install all the gems
COPY Gemfile Gemfile.lock ./

RUN apk --update --no-cache add --virtual gem-builddeps \
    build-base \
    libxml2-dev \
    ruby-dev \
 && gem install bundler \
 && bundle install --jobs=20 --retry=5 --deployment --clean \
 && apk del gem-builddeps

COPY . .
RUN rm -rf tmp
