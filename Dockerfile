FROM alpine:3.12.0

ARG PROMETHEUS_VERSION=2.18.1

# Dependencies
RUN apk add --update --no-cache \
    curl

# Download prometheus
RUN curl -k -LSs --output /tmp/prometheus.tar.gz \
    https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar -C /tmp --strip-components=1 -zoxf /tmp/prometheus.tar.gz && \
    rm -f /tmp/prometheus.tar.gz && \
    mkdir -p /usr/share/prometheus && \
    mv /tmp/prometheus /bin/ && \
    mv /tmp/promtool /bin/ && \
    mv /tmp/consoles /usr/share/prometheus/consoles && \
    mv /tmp/console_libraries /usr/share/prometheus/console_libraries && \
    mkdir -p /prometheus && \
    chown -R nobody:nogroup /prometheus

# Expose prometheus port
EXPOSE 9090

# Data volume
VOLUME [ "/prometheus" ]

# Working from data dir
WORKDIR /prometheus

ENTRYPOINT [ "/bin/prometheus" ]

# Override default CMD
CMD [ "--config.file=/etc/prometheus/prometheus.yml", \
    "--storage.tsdb.path=/prometheus", \
    "--web.console.libraries=/usr/share/prometheus/console_libraries", \
    "--web.console.templates=/usr/share/prometheus/consoles", \
    "--web.enable-lifecycle", \
    "--storage.tsdb.min-block-duration=2h", \
    "--storage.tsdb.max-block-duration=2h" ]
