.PHONY: all
all:
	@cp bin/* /usr/local/bin/.
	@./puavo-img-patch.sh

.PHONY: install
install:
	@cp bin/* /usr/local/bin/.
