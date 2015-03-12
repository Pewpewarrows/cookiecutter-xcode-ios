SHELL := /usr/bin/env bash

# TODO: might need to make this work if not running make from directory of Makefile
cwd := $(shell pwd)

.PHONY: help all clean develop docs lint test todo source

help:
	# TODO: clean this up ever so slightly
	@echo "clean - remove all build artifacts"
	@echo "docs - generate Sphinx HTML documentation for users and developers"
	@echo "help - show this message"
	@echo "lint - check source files for common mistakes"
	@echo "source - generate a zip archive of the current source tree"
	@echo "todo - find all occurances of todo-like comments in this project"

all:

clean:
	rm -rf ./build/

develop:

docs:
	rm -f ./docs/cookiecutter-xcode-ios.rst
	rm -f ./docs/modules.rst
	sphinx-apidoc -o ./docs/ cookiecutter-xcode-ios
	$(MAKE) --directory=./docs/ clean
	$(MAKE) --directory=./docs/ html
	# TODO: detect what OS we're on, use best open-like command
	open ./docs/_build/html/index.html

lint: develop
	find . -maxdepth 1 -type f -name "*.rst" -exec rst-lint {} \;
	rstcheck *.rst

release:

source:
	mkdir -p ./build/
	git archive --format zip --output ./build/cookiecutter-xcode-ios-source.zip HEAD

test: develop

todo:
	@# TODO: use ag, ack, grep, in that order of preference
	@# The brackets [ and ] are to prevent command from catching itself
	ag --ignore-dir={build,ENV,tmp,vendor} "[T]ODO|[F]IXME|[X]XX|[H]ACK|[N]OCOMMIT|[N]ORELEASE"
