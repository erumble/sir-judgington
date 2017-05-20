FROM ruby:2.1-alpine

# Install requisite packages for app to run
RUN apk --update --no-cache add nodejs postgresql-dev

# Make and set the working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# Copy the gemfile and install all the gems
COPY Gemfile Gemfile.lock ./

RUN apk --update --no-cache add --virtual gem-builddeps \
    build-base \
    libxml2-dev \
    ruby-dev \
 && bundle install --jobs=20 --retry=5 --deployment --clean \
 && apk del gem-builddeps

COPY . .