FROM alpine:3.12

ARG PROMETHEUS_VERSION=2.27.1

# Dependencies
RUN apk add --update --no-cache \
    curl \
    aws-cli

COPY entrypoint.sh /bin/entrypoint.sh

# Download prometheus
RUN curl -k -LSs --output /tmp/prometheus.tar.gz \
    https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar -C /tmp --strip-components=1 -zoxf /tmp/prometheus.tar.gz && \
    rm -f /tmp/prometheus.tar.gz && \
    mkdir -p /usr/share/prometheus && \
    mkdir -p /etc/prometheus && \
    mv /tmp/prometheus /bin/ && \
    mv /tmp/promtool /bin/ && \
    mv /tmp/consoles /usr/share/prometheus/consoles && \
    mv /tmp/console_libraries /usr/share/prometheus/console_libraries && \
    mkdir -p /prometheus/ecs && \
    chmod 0755 /bin/entrypoint.sh && \
    chown -R nobody:nogroup /etc/prometheus /prometheus

# Expose prometheus port
EXPOSE 9090

# Data volume
VOLUME [ "/prometheus" ]

# Working from data dir
WORKDIR /prometheus

ENTRYPOINT [ "/bin/entrypoint.sh" ]
