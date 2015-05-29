CFLAGS=-Wall -g

OBJC_CFLAGS=-ObjC -fno-objc-arc
OBJC_FRAMEWORKS=-framework Foundation
OBJC_LDFLAGS=-lobjc

notify.o:
	clang $(CFLAGS) $(OBJC_CFLAGS) -dynamic -c -o notify.o notify.m

bundle_id_hack.o:
	clang $(CFLAGS) $(OBJC_CFLAGS) -dynamic -c -o bundle_id_hack.o bundle_id_hack.m

notify.so: notify.o bundle_id_hack.o
	clang $(OBJC_FRAMEWORKS) $(OBJC_LDFLAGS) -bundle -undefined dynamic_lookup -o notify.so notify.o bundle_id_hack.o

clean:
	rm -f *.o
	rm -f *.so
