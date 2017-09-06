#!/bin/bash
buster generate --domain=http://ghost:2368
curl -o static/talks/index.html http://ghost:2368/talks/
curl -o static/rss/index.html http://ghost:2368/rss/

echo "Fixing links to https"
find static -name *.html -type f -exec sed -i -e 's#http://localhost:2368#https://julienfabre.github.io#g' {} \;
find static -name *.html -type f -exec sed -i -e 's#http://fonts.googleapis.com#https://fonts.googleapis.com#' {} \;
find static -name *.html -type f -exec sed -i -e 's#http://code.jquery.com#https://code.jquery.com#' {} \;

echo "Fixing some blog posts"
find static -name *.html -type f -exec sed -i -e 's#open https://julienfabre.github.io#open http://localhost:2368#g' {} \;
find static -name *.html -type f -exec sed -i -e 's#domain=https://julienfabre.github.io#domain=http://localhost:2368#g' {} \;
find static -name *.html -type f -exec sed -i -e 's#s\#https://julienfabre.github.io#s\#http://localhost:2368#g' {} \;

echo "Removing index.html from links"
find static -name *.html -type f -exec sed -i -e 's#/index.html#/#g' {} \;

if [ "$1" == "--deploy" ]; then
  buster deploy
fi
