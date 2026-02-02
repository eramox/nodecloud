# NodeCloud

A private, multi-home, family-resilient cloud for sharing files, photos, and documents.
[![Build Documentation](https://github.com/eramox/nodecloud/actions/workflows/docs.yml/badge.svg)](https://github.com/eramox/nodecloud/actions/workflows/docs.yml)

This repository contains the source code, configuration, and documentation for the NodeCloud project.

---

## 📄 Documentation

The full project documentation is written in [Typst](https://typst.app/) and is located in the `/doc` directory.

### Build Instructions

The project uses **Podman** to ensure a reproducible environment.

**Prerequisite: Install Podman (Ubuntu)**
```bash
sudo apt-get update
sudo apt-get install -y podman
```

**Build Command**
Run the following from the root of the repository:

```bash
make
```

This will generate the documentation at `out/main.pdf`.

[**Download Latest Documentation (PDF)**](https://github.com/eramox/nodecloud/raw/docs-build/main.pdf)
