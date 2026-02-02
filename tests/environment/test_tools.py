import shutil


def test_typst_installed():
    """Verifies that typst is installed and available in the path."""
    assert shutil.which("typst") is not None, \
        "typst is not installed in the dev image"


def test_python_version():
    """Verifies that the correct python version is running."""
    import sys
    assert sys.version_info.major == 3, "Python major version should be 3"
    assert sys.version_info.minor >= 12, "Python minor version should be >= 12"


def test_podman_compose_installed():
    """Verifies that podman-compose is installed."""
    assert shutil.which("podman-compose") is not None, \
        "podman-compose is not installed in the dev image"


def test_git_installed():
    """Verifies that git is installed and available in the path."""
    assert shutil.which("git") is not None, \
        "git is not installed in the dev image"
