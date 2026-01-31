# Makefile for the development image.

SHELL := /bin/bash

IMAGE_NAME ?= nodecloud-dev
IMAGE_TAG ?= latest

.PHONY: build
build:
	@echo "Building development image: $(IMAGE_NAME):$(IMAGE_TAG)..."
	@podman build \
		--tag $(IMAGE_NAME):$(IMAGE_TAG) \
		--file Containerfile .