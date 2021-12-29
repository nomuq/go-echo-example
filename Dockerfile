FROM golang:alpine AS builder
ENV CGO_ENABLED=0 GOOS=linux
WORKDIR /go/src/example
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o example main.go

FROM golang:alpine
COPY --from=builder /go/src/example/example /example
EXPOSE 8080
ENTRYPOINT ["/example"]
CMD []