# Build container
FROM docker.io/golang:alpine as builder
RUN apk update && \
  apk add git && \
  CGO_ENABLED=0 go install -a -ldflags '-s' \
  github.com/spkane/scratch-helloworld@latest

# Production container
  # scratch tells Docker to start from an empty image, which includes no additional files
FROM scratch
COPY --from=builder /go/bin/scratch-helloworld /helloworld
EXPOSE 8080
CMD ["/helloworld"]