# Specify the base image that we're building the image on top of
FROM rootproject/root

# Build the image as root user
USER root
COPY requirements.txt .

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    python3-pip git imagemagick ghostscript &&\
    apt-get clean &&\
    apt-get autoclean -y &&\
    apt-get autoremove -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/
#
RUN pip3 install -r requirements.txt &&\
    rm requirements.txt

# Needing to have image comparison running
RUN cat /etc/ImageMagick-6/policy.xml | grep -v '\"PDF\"' > test.xml &&\
    mv test.xml /etc/ImageMagick-6/policy.xml