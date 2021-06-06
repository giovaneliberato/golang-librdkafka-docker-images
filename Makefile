


define _build
	docker build . --build-arg BASE_IMAGE=golang:$(1) -t giovaneliberato/golang-librdkafka-dynamic:$(1)
endef

define _push
	docker push giovaneliberato/golang-librdkafka-dynamic:$(1)
endef

build-1-14:
	$(call _build,1.14)

build-1-15:
	$(call _build,1.15)

build-1-16:
	$(call _build,1.16)

build: build-1-14 build-1-15 build-1-16

push:
	$(call _push,1.14)
	$(call _push,1.15)
	$(call _push,1.16)

.PHONY: build-1-14 build-1-15 build-1-16

