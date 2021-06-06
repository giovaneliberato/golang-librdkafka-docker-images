
define _generate
	sed  "s/IMAGE_VERSION/$(1)/g" Dockerfile.base >> generated/Dockerfile.$(1)
endef

docker-files:
	$(call _generate,1.14)
	$(call _generate,1.15)
	$(call _generate,1.16)
	$(call _generate,latest)

.PHONY: docker-images

