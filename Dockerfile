FROM amazoncorretto:8-al2-jdk 

ARG DIGDAG_VERSION="0.10.3"
ENV TZ=Asia/Tokyo

WORKDIR /workflow

RUN amazon-linux-extras install -y && \
    amazon-linux-extras install postgresql13 && \
    amazon-linux-extras install docker
RUN yum update -y \
    && rm -rf /var/cache/yum/* \
    && yum clean all
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" \
    &&  chmod +x /usr/local/bin/digdag

COPY $PWD/server.properties /digdag-server/server.properties
EXPOSE 65432 65433
CMD ["/bin/sh", "/wait-for-postgres.sh", "&&", "java", "-jar", "/usr/local/bin/digdag", "server", "--config", "/digdag-server/server.properties"]