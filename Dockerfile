FROM alpine:3.14

WORKDIR /workdir
COPY --from=golang:1.19-alpine /usr/local/go/ /usr/local/go/
COPY --from=bufbuild/buf:latest /usr/local/bin/buf /usr/local/bin/buf
ENV PATH="/usr/local/go/bin:${PATH}"

RUN apk add --update --no-cache \
    ca-certificates \
    git \
    qemu-x86_64 \
    openssh-client && \
  rm -rf /var/cache/apk/*
RUN apk add --update nodejs npm

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install github.com/bufbuild/connect-go/cmd/protoc-gen-connect-go@latest

RUN npm install @bufbuild/protobuf @bufbuild/connect-web @bufbuild/protoc-gen-es @bufbuild/protoc-gen-connect-web
