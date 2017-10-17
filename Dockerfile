FROM cgatay/domoticz:master
MAINTAINER oypeter <j@oypeter.com>

COPY plugin_broadlink.tar.gz /
RUN set -ex && \
#    echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories && \
#      mkdir ~/.pip && \
#      echo -e '[global]\ntrusted-host=mirrors.aliyun.com\nindex-url=http://mirrors.aliyun.com/pypi/simple/\n' > ~/.pip/pip.conf && \
    apk add --no-cache --virtual TMP \
            build-base \
            libffi-dev \
            python3-dev && \
         pip3 install --no-cache-dir -U pip && \
         pip3 install --no-cache-dir -U progressbar33 Crypto broadlink pyaes && \
    tar -zxvf plugin_broadlink.tar.gz && \
    mkdir -p /src/domoticz/plugins/BroadlinkRM2 && \
    cp /plugin_broadlink/* /src/domoticz/plugins/BroadlinkRM2/ && \
    cp -r /usr/lib/python3.5/site-packages/broadlink /src/domoticz/plugins/BroadlinkRM2/ && \
    cp -r /usr/lib/python3.5/site-packages/pyaes /src/domoticz/plugins/BroadlinkRM2/ && \
    sed -i -e 's/"".join/b"".join/g' /src/domoticz/plugins/BroadlinkRM2/broadlink/__init__.py && \
    apk del --purge TMP && \
    rm -rf \
           /tmp/* \
           /root/.cache
  
