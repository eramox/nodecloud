import pytest
from pathlib import Path


@pytest.fixture(scope="session")
def project_root():
    """Returns the root directory of the project."""
    return Path("/app")


@pytest.fixture(scope="session")
def out_dir(project_root):
    """Returns the output directory."""
    return project_root / "out"
