VERSION = 1.0.12

.PHONY: clean install

all: install

clean:
	-rm -rf bruce-$(VERSION)/
	-rm -f bruce*

install: checkdeps
	test -d bruce-$(VERSION) || git clone https://github.com/tagged/bruce.git bruce-$(VERSION)
	cd bruce-$(VERSION) && git checkout -f tags/$(VERSION)
	cp -R debian/ bruce-$(VERSION)/
	cp -R debian_conf/ bruce-$(VERSION)/config/
	cd bruce-$(VERSION) && debuild -us -uc

checkdeps:
	@for pkg in debhelper devscripts build-essential scons libsnappy-dev libasan0 libboost-all-dev git g++;\
	do\
		if ! dpkg -s "$$pkg" > /dev/null 2>&1; then\
			echo Package $$pkg is necessary but not installed;\
			exit 1;\
		fi;\
	done;\
