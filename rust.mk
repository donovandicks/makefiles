.PHONY: all test clean

SHELL := /bin/bash

help:
	@echo 'Targets:'
	@echo '	fmt		Format the codebase'
	@echo '	lint		Lint the codebase with the `pedantic` setting, denying warnings'
	@echo '	test		Test the codebase'
	@echo '	build		Compile all binaries with the `release` profile'
	@echo '	install		Install a specific project to your machine'
	@echo '				usage: `make install project=<project>`'
	@echo '	new		Create a new project'
	@echo '				usage: `make new project=<project> type=<lib|bin>`'


fmt:
	@cargo fmt --all --verbose

lint:
	@cargo clippy -- -D warnings -W clippy::pedantic

test:
	@cargo test

build: test
	@cargo build --release

docs:
	@cargo doc --no-deps --open
