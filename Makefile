COVERAGE ?= 'false'
TEST_PROG = $(if $(filter true,$(COVERAGE)),bashcov,bash)

.PHONY: all build test lint history

all: lint test

build: dist/hosts

dist/hosts:
	mkdir -p build dist
	./hostcamo -c build >dist/hosts

test:
	$(TEST_PROG) tests/.bash_unit tests/*

lint:
	shellcheck hostcamo docker-entrypoint.sh tests/*

history: build
	@: $${MESSAGE?}
	git checkout --quiet history
	git rm -r --ignore-unmatch --quiet .
	cp build/* .
	git add $$(cd build && echo *)
	if ! git diff HEAD --quiet; then git commit --quiet --message="$(MESSAGE)"; fi
