#!/bin/bash
# Loads data via RESTful API
#
while read line;
do
  curl --data "name=$line" http://0.0.0.0:3000/words/
done 

