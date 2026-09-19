FROM jenkins/jenkins:lts-jdk21

USER root

# Install prerequisites, Docker GPG key, repository, and docker-ce-cli
RUN apt-get update && apt-get install -y lsb-release curl ca-certificates && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

USER jenkins

# Install plugins without strict version locks
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"