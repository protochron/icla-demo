FROM ubuntu:trusty
RUN mkdir /iclas
WORKDIR /iclas
ENV PATH $PATH:/iclas/node_modules/.bin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y software-properties-common && \
    apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.2 ruby2.2-dev nodejs-legacy npm git sqlite libsqlite3-dev && \
    apt-get clean
RUN echo 'gem: --no-ri --no-rdoc' > /etc/gemrc && gem install bundle

ADD package.json package.json
ADD Gemfile Gemfile
ADD .bowerrc .bowerrc
ADD bower.json bower.json
ADD Rakefile Rakefile
RUN npm install && \
    bundle install && \
    bower install \
    --allow-root && \
    jsx jsx public/js && rake initialize_db

ADD . /iclas

EXPOSE 9292
CMD cd /iclas && puma
