FROM golang:1.18.3-alpine3.16 AS build
#FROM golang:latest

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
COPY main.go ./

RUN go mod download && \
    go get github.com/Unleash/unleash-client-go/v3

RUN mkdir /gorun && \
    CGO_ENABLED=0 go build -gcflags "all=-N -l" -o /gorun

#FROM scratch AS run
FROM golang:1.18.3-alpine3.16 AS run

WORKDIR /
COPY --from=build /gorun /gorun

ENTRYPOINT /gorun/app
