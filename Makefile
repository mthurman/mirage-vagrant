.PHONY: all clean deploy

all:
	cd src && $(MAKE)

xen:
	opam switch 3.12.1+mirage-xen
	eval `opam config -env`
	eval unset CAML_LD_LIBRARY_PATH
	cd src && MIRAGE_OS=xen $(MAKE)

clean:
	cd src && $(MAKE) clean

deploy: xen
	make_ec2.sh src/_build/main.xen

run:
	sudo ./src/_build/main.native
