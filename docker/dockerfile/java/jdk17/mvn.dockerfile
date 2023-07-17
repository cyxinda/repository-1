#FROM maven:3.6.1-jdk-8-alpine
#FROM maven:3.8.6-jdk-17
FROM maven:3.8.5-openjdk-17
VOLUME [ "/data" ]
WORKDIR /data
RUN  mkdir -p /root/.m2/ && curl -o  /root/.m2/settings.xml https://raw.githubusercontent.com/knowdee/repository/main/maven/config/aliyun/settings.xml
CMD ["mvn","clean","package","-f","/data/pom.xml"  ]


# docker build --no-cache -t registry.knowdee.com/library/maven:3.8.6-jdk17 . -f ./dockerfiles/mvn.dockerfile   --progress=plain
# docker run -it --rm --name maven -v /home/cyxinda/workspace/prometheus/code/examples/demo-with-jmx-exporter:/data  registry.knowdee.com/library/maven:3.8.6-jdk8
