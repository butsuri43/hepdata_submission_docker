#/bin/bash

# This is a little script to create a Dockerfile_latest
# which runs on latest root image and pip-installs latest packages from reqquiremnts.txt

cat requirements.txt | sed 's/==.*//g' | sed 's/@.*//g' > requirements_latest.txt
cat Dockerfile | sed 's/FROM.*/FROM rootproject\/root:latest/g' | sed 's/requirements.txt/requirements_latest.txt/g' > Dockerfile_latest

