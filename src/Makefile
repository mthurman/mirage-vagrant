ifeq ($(MIRAGE_OS),xen)
FLAGS=--enable-xen --disable-unix
else
FLAGS=--enable-unix --disable-xen
endif

all: 
	ocaml setup.ml -configure $(FLAGS)
	ocaml setup.ml -build

.PHONY:clean
clean:
	ocamlbuild -clean
	rm -f setup.log
	rm -f setup.data
	rm -f filesystem_static.ml
	rm -f filesystem_templates.ml
	rm -f main.ml
