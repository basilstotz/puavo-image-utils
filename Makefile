.PHONY: all

all:
	@cp bin/* /usr/local/bin/.
	@./puavo-img-patch.sh

install:
	@cp bin/* /usr/local/bin/.
