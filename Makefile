FLUTTER := fvm flutter
DART := fvm dart
DEVICE ?=
RUN_ARGS := $(if $(DEVICE),-d "$(DEVICE)",)

.PHONY: help setup fvm pub-get run devices doctor analyze test format generate clean

help:
	@printf '%s\n' \
		'make setup       Install pinned Flutter SDK and dependencies' \
		'make run         Run app on available device' \
		'make run DEVICE=<id>  Run app on a specific device' \
		'make devices     List available devices' \
		'make doctor      Show Flutter environment diagnostics' \
		'make analyze     Run static analysis' \
		'make test        Run test suite' \
		'make format      Format Dart source files' \
		'make generate    Generate Riverpod and model source files' \
		'make clean       Remove build outputs and restore dependencies'

setup: fvm pub-get

fvm:
	fvm use 3.41.9 --skip-pub-get

pub-get:
	$(FLUTTER) pub get

run:
	$(FLUTTER) run $(RUN_ARGS)

devices:
	$(FLUTTER) devices

doctor:
	$(FLUTTER) doctor

analyze:
	$(FLUTTER) analyze

test:
	$(FLUTTER) test

format:
	$(DART) format .

generate:
	$(DART) run build_runner build

clean:
	$(FLUTTER) clean
	$(FLUTTER) pub get
