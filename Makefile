.PHONY: all
all:
	@cp bin/puavo-* /usr/local/bin/.
	@./bin/puavo-img-tool

.PHONY: install
install:
	@cp bin/puavo-* /usr/local/bin/.
