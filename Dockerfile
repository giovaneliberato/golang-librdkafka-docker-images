ARG BASE_IMAGE=golang:latest
FROM $BASE_IMAGE 

# Install librdkafka from source
RUN apt-get update -y
RUN apt-get install -y libsasl2-dev
RUN git clone https://github.com/edenhill/librdkafka.git
WORKDIR librdkafka
RUN ./configure --install-deps --source-deps-only
RUN make
RUN make install

# Install Golang wrapper
RUN mkdir -p /usr/lib/wrapper/

WORKDIR /usr/lib/wrapper/

ENV GO111MODULE=on
RUN go mod init go-wrapper
COPY cli-wrapper.go /usr/lib/wrapper
RUN go build -ldflags "-X main.GoBinPath=$(which go)" -o go cli-wrapper.go
ENV PATH=/usr/lib/wrapper:$PATH

