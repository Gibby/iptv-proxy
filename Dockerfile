FROM golang:1.19.1-alpine

RUN apk add ca-certificates

WORKDIR /go/src/github.com/gibby/iptv-proxy
COPY . .
RUN GO111MODULE=off CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o iptv-proxy .

FROM alpine:3
COPY --from=0  /go/src/github.com/gibby/iptv-proxy/iptv-proxy /
ENTRYPOINT ["/iptv-proxy"]
