# docker-prometheus
This repository contains code to create an image that runs Prometheus to be used within AWS.
A version of Prometheus is downloaded based on the PROMETHEUS_VERSION arg within the Dockerfile. Prometheus configuration files are then
fetched from S3 and Prometheus is started.


# Required Environment Variables

|             Key            |                                Description               |
|----------------------------|----------------------------------------------------------|
| PROMETHEUS_CONFIG_S3_BUCKET   | The ID of the config S3 bucket                           |
| PROMETHEUS_CONFIG_S3_PREFIX   | The directory path of the config files within the bucket |
| AWS_ACCESS_KEY_ID          | AWS access key                           |
| AWS_SECRET_ACCESS_KEY      | AWS secret access key |





