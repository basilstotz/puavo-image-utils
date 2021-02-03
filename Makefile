TARGETS = build clean prerequisites
NAME = "puavo-image-utils"

.PHONY: ${TARGETS}
.PHONY: help

help:
	@echo "Targets are:"
	@echo "   ${TARGETS}" | fmt

clean:
	@./bin/clean.sh ${NAME}

build:
	@./bin/build.sh ${NAME}

prerequisites:
	@./bin/prerequisites.sh




