include config.mk

subdirs = lib test samples

all: $(subdirs)

.PHONY: $(subdirs)
$(subdirs):
	@if [ -d $@ ]; then				\
		$(MAKE) -C $@ || exit 1;	 	\
	fi

bench: $(subdirs)
	$(MAKE) -C samples $@

check:  $(subdirs)
	$(MAKE) -C test $@

unsafe-check:  $(subdirs)
	$(MAKE) -C test $@

clean:
	@for dir in $(subdirs); do 			\
		if [ -d $$dir ]; then			\
			$(MAKE) -C $$dir $@ || exit 1;	\
		fi					\
	done

install:
	$(MAKE) -C lib $@
	install -d $(PREFIX)/include/
	install -m 644 libnxz.h $(PREFIX)/include/

uninstall:
	$(MAKE) -C lib $@
	rm $(PREFIX)/include/libnxz.h
