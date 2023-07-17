FROM openjdk:17-ea-jdk-oracle
ENV MX_MEM=512m
## 环境变量不能嵌套 MX_MEM这种就不能在docker build的时候进行设置
#ENV VM_ARG="-Xmn256m -Xms${MX_MEM:-1500m} -Xmx${MX_MEM:-1500m} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m  "

ENV VM_ARG="-Xms${MX_MEM:-1500m} -Xmx${MX_MEM:-1500m} -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m  "
ENV OOM_ARG="-XX:+HeapDumpOnOutOfMemoryError "
ENV GC_ARG=" -XX:HeapDumpPath=/data/logs/dump.hprof  -Xlog:gc*:/data/logs/gc-%t.log"
#ENV GC_ARG=" -Xlog:gc* -XX:HeapDumpPath=/data/logs/dump.hprof -Xloggc:/data/logs/gc-%t.log"
ENV SERVER_JVMFLAGS="-javaagent:/opt/jmx-exporter/jmx_prometheus_javaagent-0.18.0.jar=7070:/opt/jmx-exporter/simple-config.yml"
ENV JAVA_OPTS="$VM_ARG $OOM_ARG $GC_ARG $SERVER_JVMFLAGS -XX:+UnlockExperimentalVMOptions"
ENV TZ="Asia/Shanghai"
VOLUME /data
RUN mkdir -p /opt/jmx-exporter \
    &&  curl -o   /opt/jmx-exporter/simple-config.yml https://raw.githubusercontent.com/knowdee/repository/main/java/jmx/0.18.0/simple-config.yml \
    &&  curl -o  /opt/jmx-exporter/jmx_prometheus_javaagent-0.18.0.jar  https://raw.githubusercontent.com/knowdee/repository/main/java/jmx/0.18.0/jmx_prometheus_javaagent-0.18.0.jar

CMD mkdir -p /data/logs && echo $JAVA_OPTS && exec java $JAVA_OPTS  -jar /data/app.jar

# docker build  --no-cache  -t registry.knowdee.com/library/jmx-exporter:0.18.0-jdk17 . -f ./dockerfiles/jmx.dockerfile   --progress=plain
# docker run -v /tmp/apps:/data -p 18080:8080 -p 17070:7070 --rm --name app registry.knowdee.com/library/jmx-exporter:0.18.0-jdk8
