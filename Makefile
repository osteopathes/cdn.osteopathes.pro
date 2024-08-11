GIT_HASH:=$(shell git rev-parse HEAD)
GIT_SHORT_HASH:=$(shell git rev-parse --short HEAD)
COMPILE_TIME:=$(shell date -u +'%Y-%m-%d %H:%M:%S UTC')
GIT_BRANCH:=$(shell git branch | grep "^\*" | sed 's/^..//')

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: all
all: clean-all
	mkdir dist
	cp -r styleguide dist/
	cp -r assets dist/
	cp -r games dist/

.PHONY: clean-all
clean-all:
	rm -rf ./dist
