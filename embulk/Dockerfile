ARG EMBULK_VERSION="0.9.23"

FROM amazoncorretto:8-al2-jdk

ARG EMBULK_VERSION
ENV TZ=Asia/Tokyo
RUN yum update -y \
    && rm -rf /var/cache/yum/* \
    && yum clean all
RUN curl --create-dirs -o /usr/local/bin/embulk -L "https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar" \
    && chmod +x /usr/local/bin/embulk

RUN echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc \
    && source ~/.bashrc
RUN embulk gem install embulk-input-mysql -v 0.12.3

COPY $PWD/conf/world.yml /conf/world.yml

ENTRYPOINT ["java", "-jar", "/usr/local/bin/embulk"]