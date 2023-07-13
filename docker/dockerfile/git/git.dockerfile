FROM ubuntu:jammy-20230624
COPY <<EOF /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ jammy main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ jammy-proposed main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ jammy main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-backports main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-proposed main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-security main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-updates main multiverse restricted universe
EOF
VOLUME [ "/data" ]
USER root
RUN apt-get update && apt-get install -y wget && apt-get  install -y expect  && apt-get install -y git && wget https://raw.githubusercontent.com/knowdee/repository/main/scripts/git-clone/https.sh -O /bin/git-clone && chmod 777 /bin/git-clone
CMD [ "git-clone" ]





# docker build --no-cache -t registry.knowdee.com/library/ubuntu-git:1.0.0 . -f ./dockerfiles/git.dockerfile   --progress=plain
# docker run -v /tmp/aaaa:/data  --rm --name clone registry.knowdee.com/library/ubuntu-git:1.0.0 git-clone -u root -p gitlab-token -a https://repository.knowdee.com/certificates/git.git
