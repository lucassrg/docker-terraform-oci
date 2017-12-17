FROM alpine:3.7 AS build-terraform

ENV TERRAFORM_VERSION 0.11.1

RUN apk add --update wget ca-certificates unzip git bash curl && \
    wget -q -O /terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /terraform.zip -d /bin

ADD get_terraform_oci_provider.sh /root/

RUN sh -x /root/get_terraform_oci_provider.sh
RUN mkdir -p /root/.terraform.d/plugins/
RUN tar xzf terraform-oci.tar.gz -C /root/.terraform.d/plugins/

FROM oraclelinux:7-slim

RUN mkdir -p /root/.terraform.d/plugins/

WORKDIR /bin/
COPY --from=build-terraform /bin/terraform .

WORKDIR /root/.terraform.d/plugins/
COPY --from=build-terraform /root/.terraform.d/plugins/ .

WORKDIR /


VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/terraform"]
