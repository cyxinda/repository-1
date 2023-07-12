#FROM maven:3.6.1-jdk-8-alpine
FROM maven:3.8.6-jdk-11
VOLUME [ "/data" ]
WORKDIR /data
RUN  mkdir -p /root/.m2/ &&  wget https://raw.githubusercontent.com/knowdee/repository/main/maven/config/aliyun/settings.xml -O /root/.m2/settings.xml
CMD ["mvn","clean","package","-f","/data/pom.xml"  ]


# docker build --no-cache -t registry.knowdee.com/library/maven:3.8.6-jdk-11 . -f ./dockerfiles/mvn.dockerfile   --progress=plain
# docker run -it --rm --name maven -v /home/cyxinda/workspace/prometheus/code/examples/demo-with-jmx-exporter:/data  registry.knowdee.com/library/maven:3.8.6-jdk-11