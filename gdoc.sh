#!/bin/bash

# echo 'include::{url}[]' > template.adoc

# : ${doc_id:=${1:-"1CCM7BZjEVs_wLkm35X7o43PW0ILbZIGKbamOVmklxRQ"}}


: ${doc_id:=${1:-"1F7XbKjoniK3y_xgr6QDnMmnQdAQsh3uhc9R_08uDCC8"}}


asciidoctor -a allow-uri-read \
  -a url="https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=${doc_id}" \
  template.adoc \
  -a type=web \
  -r ./lib/twitter-macro.rb \
  -r ./lib/youtube-macro.rb \
  -r ./lib/featured-macro.rb  \
  -T blog-templates \
  -o -

# https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1CCM7BZjEVs_wLkm35X7o43PW0ILbZIGKbamOVmklxRQ&token=AC4w5VhAIPJGICN_cpnQeRq2A63capF8Pg%3A1516032508978&includes_info_params=true
# https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1CCM7BZjEVs_wLkm35X7o43PW0ILbZIGKbamOVmklxRQ&token=AC4w5VhAIPJGICN_cpnQeRq2A63capF8Pg%3A1516032508978&includes_info_params=true

# for file in `find adoc -name \*.adoc`; do echo $file; asciidoctor $file -a type=web -r ./lib/twitter-macro.rb -r ./lib/youtube-macro.rb -r ./lib/featured-macro.rb; done
