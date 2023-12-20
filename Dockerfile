FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /gha-playground

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /gha-playground /gha-playground

USER nonroot:nonroot

ENTRYPOINT ["/gha-playground"]
