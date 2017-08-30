FROM cgatay/domoticz:3.8356-beta
MAINTAINER oypeter <j@oypeter.com>

RUN apk add --no-cache gcc g++ make libffi-dev python3-dev && \
         pip3 install --upgrade pip && \
         pip3 install progressbar33 Crypto broadlink pyaes
COPY plugin_broadlink.tar.gz /
RUN tar -zxvf plugin_broadlink.tar.gz && \
    mkdir -p /src/domoticz/plugins/BroadlinkRM2 && \
    cp /plugin_broadlink/* /src/domoticz/plugins/BroadlinkRM2/

