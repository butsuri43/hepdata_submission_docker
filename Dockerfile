# Specify the base image that we're building the image on top of
FROM rootproject/root:6.22.06-ubuntu20.04
# ROOT is strickly needed only for hepdata_lib, but ok...

# Build the image as root user
USER root
COPY requirements.txt .
COPY packages.txt .
COPY ImageMagicPolicyChanges.sh .

# Install required packages
RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    $(cat packages.txt) &&\
    apt-get clean &&\
    apt-get autoclean -y &&\
    apt-get autoremove -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/ &&\
    rm packages.txt

# Install required pip packages
RUN pip3 install -r requirements.txt &&\
    rm requirements.txt

# Needing to have image comparison running
RUN bash ImageMagicPolicyChanges.sh &&\
    rm ImageMagicPolicyChanges.sh

WORKDIR /