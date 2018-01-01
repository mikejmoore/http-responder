#!/bin/sh

cd /opt/http-responder/
gem install bundler
bundle
rails s
