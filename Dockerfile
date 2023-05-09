FROM amazon/aws-cli

COPY entrypoint.sh /entrypoint.sh

RUN set -ex && \
    yum -y install jq which && \
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm" && \
    yum install -y session-manager-plugin.rpm
ENTRYPOINT [ "/entrypoint.sh" ]
