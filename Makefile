# Makefile for the FamCloud project.
# See .gemini.json for project rules and tasks.

# Use bash for shell commands.
SHELL := /bin/bash

# Determine the project root directory (where this Makefile lives).
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_ROOT := $(dir $(mkfile_path))

# Project variables
PROJECT_NAME := nodecloud
DEV_IMAGE_NAME := $(PROJECT_NAME)-dev
DEV_IMAGE_TAG := latest
PODMAN_COMPOSE := podman-compose
OUT_DIR ?= out
ABS_OUT_DIR := $(abspath $(OUT_DIR))

# Common Podman flags to reduce repetition
PODMAN_FLAGS := --rm --userns=keep-id --workdir "/app"
DEV_RUN := podman run $(PODMAN_FLAGS)
# Podman Volume definitions
VOL_APP_RO := --volume "$(PROJECT_ROOT):/app:ro"
VOL_APP_RW := --volume "$(PROJECT_ROOT):/app"
VOL_OUT    := --volume "$(ABS_OUT_DIR):/out"

# Documentation files
DOC_SRC_REL := doc/main.typ
DOC_SRC := $(PROJECT_ROOT)$(DOC_SRC_REL)
DOC_PDF := $(ABS_OUT_DIR)/main.pdf

# Default target to build the project.
# This ensures the development environment is ready, documentation is built,
# and tests are run, making the project easily reproducible.
.PHONY: all
all: dev-image docs test
	@echo "Project setup complete. PDF documentation is at $(DOC_PDF)."

# Help target to display available commands.
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  all           - Build dev image, docs, and run tests (default)."
	@echo "                  (Tip: Use 'make -f path/to/Makefile' to output to current dir)"
	@echo "  dev-image     - Build the podman development image for tools like Typst."
	@echo "  docs          - Generate PDF documentation from Typst source."
	@echo "  test          - Run project tests."
	@echo "  lint          - Lint project files."
	@echo "  stack-up      - Start the application stack with podman-compose."
	@echo "  stack-down    - Stop the application stack."
	@echo "  clean         - Remove generated files."

# Build the development container image.
# This image contains all the necessary tools (e.g., Typst, Python) for development.
.PHONY: dev-image
dev-image:
	@$(MAKE) -C "$(PROJECT_ROOT)images/dev-image" build IMAGE_NAME=$(DEV_IMAGE_NAME) IMAGE_TAG=$(DEV_IMAGE_TAG)

# Generate the documentation PDF from the Typst source file.
# This runs the 'typst compile' command inside the development container.
.PHONY: docs
docs: dev-image $(DOC_SRC)
	@echo "Generating documentation from $(DOC_SRC)..."
	@mkdir -p $(ABS_OUT_DIR)
	@$(DEV_RUN) \
		$(VOL_APP_RO) \
		$(VOL_OUT) \
		$(DEV_IMAGE_NAME):$(DEV_IMAGE_TAG) \
		typst compile $(DOC_SRC_REL) /out/main.pdf
	@echo "Documentation generated at $(DOC_PDF)."

# Run unit and integration tests.
.PHONY: test
test: docs
	@echo "Running project tests..."
	@$(DEV_RUN) \
		$(VOL_APP_RW) \
		$(DEV_IMAGE_NAME):$(DEV_IMAGE_TAG) \
		pytest tests $(ARGS)

# Lint the project files to ensure they adhere to coding standards.
# Placeholder for the actual linting command.
.PHONY: lint
lint: dev-image
	@echo "Linting project files..."
	@$(DEV_RUN) \
		$(VOL_APP_RO) \
		$(DEV_IMAGE_NAME):$(DEV_IMAGE_TAG) \
		flake8 . | sed 's#^\./##'

# Use podman-compose to start the application stack (Plex, etc.).
# Assumes a 'podman-compose.yml' file exists.
.PHONY: stack-up
stack-up:
	@echo "Starting NodeCloud stack..."
	@cd "$(PROJECT_ROOT)" && $(PODMAN_COMPOSE) up --detach

# Use podman-compose to stop the application stack.
.PHONY: stack-down
stack-down:
	@echo "Stopping NodeCloud stack..."
	@cd "$(PROJECT_ROOT)" && $(PODMAN_COMPOSE) down

# Clean up generated files.
.PHONY: clean
clean:
	@echo "Cleaning up generated files..."
	@rm -rf $(OUT_DIR)