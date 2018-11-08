#!/usr/bin/env bash

curl 'https://en.wikipedia.org/wiki/Georg_Wilhelm_Friedrich_Hegel' \
    -H 'authority: en.wikipedia.org' \
    -H 'cache-control: max-age=0' \
    -H 'upgrade-insecure-requests: 1' \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36' \
    -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' \
    -H 'accept-encoding: gzip, deflate, br' \
    -H 'accept-language: en-US,en;q=0.9' \
    --compressed > \
    tmp.html
