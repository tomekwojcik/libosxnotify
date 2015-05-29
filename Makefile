CFLAGS=-Wall -g

OBJC_CFLAGS=-ObjC -fno-objc-arc
OBJC_FRAMEWORKS=-framework Foundation
OBJC_LDFLAGS=-lobjc

INSTALL=/usr/bin/install
INSTALL_BIN=/usr/bin/install -S -m 755
INSTALL_DATA=/usr/bin/install -S -m 644

VERSION=1.0
COMPAT_VERSION=1.0

ifndef PREFIX
	PREFIX=/usr/local
endif

build:
	mkdir -p build

build/notify.o: build
	clang $(CFLAGS) $(OBJC_CFLAGS) -dynamic -c -o build/notify.o src/notify.m

build/bundle_id_hack.o: build
	clang $(CFLAGS) $(OBJC_CFLAGS) -dynamic -c -o build/bundle_id_hack.o src/bundle_id_hack.m

build/libosxnotify.dylib: build/notify.o build/bundle_id_hack.o
	clang $(OBJC_FRAMEWORKS) $(OBJC_LDFLAGS) -install_name $(PREFIX)/lib/libosxnotify.dylib -current_version $(VERSION) -compatibility_version $(COMPAT_VERSION) -shared -undefined dynamic_lookup -o build/libosxnotify.dylib build/notify.o build/bundle_id_hack.o

build/libosxnotify.h:
	cp src/libosxnotify.h build/libosxnotify.h

clean:
	rm -rf build

all: build/libosxnotify.dylib build/libosxnotify.h

installdirs:
	$(INSTALL) -d $(PREFIX)/lib
	$(INSTALL) -d $(PREFIX)/include
	$(INSTALL) -d $(PREFIX)/share/libosxnotify

install: build/libosxnotify.dylib build/libosxnotify.h installdirs
	$(INSTALL_BIN) build/libosxnotify.dylib $(PREFIX)/lib/libosxnotify.dylib
	$(INSTALL_DATA) build/libosxnotify.h $(PREFIX)/include/libosxnotify.h
	$(INSTALL_DATA) README.md $(PREFIX)/share/libosxnotify/README.md
	$(INSTALL_DATA) LICENSE $(PREFIX)/share/libosxnotify/LICENSE
