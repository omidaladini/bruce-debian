VERSION = 1.0.9

.PHONY: clean install

all: install

clean:
	-rm -rf bruce-$(VERSION)/
	-rm -f bruce*

install:
	test -d bruce-$(VERSION) || git clone https://github.com/tagged/bruce.git bruce-$(VERSION)
	cd bruce-$(VERSION) && git checkout -f tags/$(VERSION)
	cp -R debian/ bruce-$(VERSION)/
	cp remove-werror.patch bruce-$(VERSION)/
	cd bruce-$(VERSION) && patch -p1 < remove-werror.patch
	cd bruce-$(VERSION) && debuild -us -uc

