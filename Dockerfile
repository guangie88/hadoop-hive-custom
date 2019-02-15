FROM openjdk:8-jdk-slim

ARG HADOOP_HOME=/opt/hadoop
ENV HADOOP_HOME ${HADOOP_HOME}

ARG HADOOP_VERSION=3.1.0
ENV HADOOP_VERSION ${HADOOP_VERSION}

ARG HIVE_HOME=/opt/hive
ENV HIVE_HOME ${HIVE_HOME}

ARG HIVE_VERSION=3.0.0
ENV HIVE_VERSION ${HIVE_VERSION}

RUN set -eu && \
    # apt requirements
    apt-get update && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        procps \
        ; \
    # Set up Hadoop
    curl -O https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz; \
    tar xvf hadoop-${HADOOP_VERSION}.tar.gz; \
    mv hadoop-${HADOOP_VERSION} /opt; \
    ln -s hadoop-${HADOOP_VERSION} ${HADOOP_HOME}; \
    rm -r hadoop-${HADOOP_VERSION}.tar.gz; \
    # Set up Hive
    curl -O https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz; \
    tar xvf apache-hive-${HIVE_VERSION}-bin.tar.gz; \
    mv apache-hive-${HIVE_VERSION}-bin /opt; \
    ln -s apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME}; \
    rm -r apache-hive-${HIVE_VERSION}-bin.tar.gz; \
    # apt clean-up
    rm -rf /var/lib/apt/lists/*; \
    :

ENV PATH ${PATH}:${HADOOP_HOME}/bin:${HIVE_HOME}/bin
