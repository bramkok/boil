BIN ?= boil
PREFIX ?= /usr/local

install:
	cp boil $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
