FROM registry.knowdee.com/library/ubuntu-git:1.0.0 as gitLayer
ARG GIT_REPO
ARG GIT_TAG
ARG GIT_USER
ARG GIT_TOKEN
WORKDIR /data

RUN git-clone -u $GIT_USER -p $GIT_TOKEN -a $GIT_REPO && git checkout $GIT_TAG

FROM registry.knowdee.com/library/maven:3.8.6-jdk-11 as mavenLayer
ARG PROJECT_NAME
COPY --from=gitLayer /data /data
WORKDIR /data
RUN mvn clean package &&  ls /data/$PROJECT_NAME/target/*.jar

FROM registry.knowdee.com/library/jmx-exporter:0.18.0-jdk11
ARG PROJECT_NAME
WORKDIR /data
COPY --from=mavenLayer /data/$PROJECT_NAME/target/*.jar /data/app.jar

#docker build    -t registry.knowdee.com/tests/app:v1.0.0  . -f ./dockerfiles/java11.dockerfile \
#--build-arg GIT_REPO=https://github.com/knowdee/app.git \
#--build-arg GIT_TAG=dev \
#--build-arg GIT_TOKEN=github_token \
#--build-arg GIT_USER=it@knowdee.com \
#--build-arg PROJECT_NAME=app-start --progress=plain

# docker run --rm --name app -e MX_MEM=128m -v /tmp/apps:/data -p 18080:8080 -p 17070:7070 registry.knowdee.com/tests/app:v1.0.0


