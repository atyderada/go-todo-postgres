FROM golang:1.14-alpine AS build

RUN apk add --update --no-cache gcc git build-base

WORKDIR /src/
COPY main*.go go.* /src/
RUN CGO_ENABLED=0 go build -o /bin/go-todo-postgres

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=build /bin/go-todo-postgres /bin/go-todo-postgres
ENTRYPOINT ["/bin/go-todo-postgres"]
