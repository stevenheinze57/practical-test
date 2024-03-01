FROM jenkins/jenkins:lts

USER root 

# Install docker 
RUN apt update -y 
RUN apt install -y docker.io 

# Install kubectl 
RUN apt install -y apt-transport-https ca-certificates curl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt update -y 
RUN apt install -y kubectl 
