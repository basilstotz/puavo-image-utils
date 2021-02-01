TARGETS = init build clean package
NAME = "puavo-image-utils"

.PHONY: ${TARGETS}
.PHONY: help

help:
	@echo "Targets are:"
	@echo "   ${TARGETS}" | fmt

init:
	@./bin/init.sh ${NAME}

clean:
	@./bin/clean.sh ${NAME}

build:
	@./bin/build.sh ${NAME}

package:
	@./bin/package.sh


