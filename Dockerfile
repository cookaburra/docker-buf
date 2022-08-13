FROM alpine:3.14

RUN wget https://github.com/bufbuild/buf/releases/download/v1.7.0/buf-Linux-x86_64 -O /usr/local/bin/buf && chmod +x /usr/local/bin/buf

COPY --from=golang:1.19-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"
ENV PATH="/usr/local/bin/buf:${PATH}"

RUN apk add --update nodejs npm
RUN go install github.com/bufbuild/buf/cmd/buf@latest
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install github.com/bufbuild/connect-go/cmd/protoc-gen-connect-go@latest

RUN npm install -g @bufbuild/protobuf @bufbuild/connect-web @bufbuild/protoc-gen-es @bufbuild/protoc-gen-connect-web
