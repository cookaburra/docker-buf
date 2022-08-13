FROM alpine:3.14

COPY --from=golang:1.19-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

RUN apk add --update nodejs npm
RUN go install github.com/bufbuild/buf/cmd/buf@latest
RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install github.com/bufbuild/connect-go/cmd/protoc-gen-connect-go@latest

RUN npm install -g @bufbuild/protobuf @bufbuild/connect-web @bufbuild/protoc-gen-es @bufbuild/protog-gen-connect-web
