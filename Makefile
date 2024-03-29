.PHONY: all test history

all: lint test

test:
	bash tests/.bash_unit tests/*

test-coverage:
	bashcov tests/.bash_unit tests/*

lint:
	shellcheck hostcamo docker-entrypoint.sh tests/*

history:
	@: $${MESSAGE?}
	git checkout --quiet history
	git rm -r --ignore-unmatch --quiet .
	cp build/* .
	git add $$(cd build && echo *)
	if ! git diff HEAD --quiet; then git commit --quiet --message="$(MESSAGE)"; fi
