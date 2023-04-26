.PHONY: all test clean

SHELL := /bin/bash

DEV_DEPS = wheel black isort ruff
TEST_DEPS = pytest pytest-sugar pytest-benchmark pytest-examples

help:
	@echo 'Targets:'
	@echo ' clean			Clean (remove) the virtual environment'
	@echo ' init			Initialize a new virtual environment'
	@echo ' install		Install the package'
	@echo ' dev-deps		Install the development dependencies'
	@echo ' test-deps		Install the test dependencies'
	@echo ' lint			Lint the codebase with Ruff and Black'
	@echo ' format			Format the codebase with Black'
	@echo ' test			Run all tests, excluding benchmarks'
	@echo ' test-examples		Run just the example tests'
	@echo ' bench			Run all benchmarks'

clean:
	rm -rf ./venv

init:
	python3 -m venv venv
	./venv/bin/pip install -U pip
	./venv/bin/pip install $(DEV_DEPS) $(TEST_DEPS)

install:
	./venv/bin/pip install .

dev-deps:
	./venv/bin/pip install $(DEV_DEPS)

test-deps:
	./venv/bin/pip install $(TEST_DEPS)

lint:
	@ruff check --config pyproject.toml src/
	@black --check src/

format:
	@black .

test:
	pytest -m "not benchmarks" .

test-examples:
	pytest -m "examples" .

bench:
	pytest -m "benchmarks" .
