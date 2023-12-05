CHILD_MAKEFILES_DIRS = $(sort $(dir $(wildcard Modules/*/*/Makefile)))

all: bootstrap swiftgen

bootstrap: hook scripts
	mint bootstrap

hook:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

mint:
	mint bootstrap

lint:
	mint run swiftlint

fmt:
	mint run swiftformat Sources Tests

setup_build_tools:
	sh scripts/setup_build_tools.sh

swiftgen:
	@for d in $(CHILD_MAKEFILES_DIRS); do ( cd $$d && make swiftgen; ); done

.PHONY: all bootstrap hook mint lint fmt setup_build_tools