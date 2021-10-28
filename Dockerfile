FROM amazon/aws-cli

COPY entrypoint.sh /entrypoint.sh

RUN set -ex && \
    yum -y install jq
ENTRYPOINT [ "/entrypoint.sh" ]
