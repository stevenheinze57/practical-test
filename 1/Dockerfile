FROM docker.io/ubuntu:24.04  

ARG BTC_VERSION  

# Install dependencies 
RUN apt update -y 
RUN apt install -y coreutils wget 

# Download release 
# https://bitcoincore.org/bin/bitcoin-core-22.0/  
RUN wget https://bitcoincore.org/bin/bitcoin-core-${BTC_VERSION}/bitcoin-${BTC_VERSION}-x86_64-linux-gnu.tar.gz 
RUN echo "59ebd25dd82a51638b7a6bb914586201e67db67b919b2a1ff08925a7936d1b16 bitcoin-${BTC_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum --check | grep "OK"

# Install bitcoin 
RUN tar -xzvf bitcoin-${BTC_VERSION}-x86_64-linux-gnu.tar.gz -C /opt  
RUN ln -sv bitcoin-${BTC_VERSION} /opt/bitcoin 
RUN /opt/bitcoin/bin/test_bitcoin --show_progress  
RUN rm bitcoin-${BTC_VERSION}-x86_64-linux-gnu.tar.gz  

#TODO: Add bitcoin user and dir 
# 
# RUN mkdir /bitcoin 
# RUN groupadd -g 1001 bitcoin 
# RUN useradd -u 1001 -g bitcoin -d /bitcoin bitcoin
# RUN chown -R bitcoin /bitcoin 
# 
# VOLUME ["/bitcoin/.bitcoin"]
# WORKDIR /bitcoin 
# USER bitcoin 

CMD [ "/opt/bitcoin-${BTC_VERSION}/bin/bitcoind" ]
# TODO: Add flags like '-rpcbind=:8332' '-rpcallowip=0.0.0.0/0'