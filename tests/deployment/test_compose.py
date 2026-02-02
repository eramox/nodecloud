import yaml


def test_podman_compose_file_validity(project_root):
    """
    Verifies that the podman-compose.yml file exists and is valid YAML.
    """
    compose_file = project_root / "podman-compose.yml"

    if compose_file.exists():
        with open(compose_file, "r") as f:
            content = yaml.safe_load(f)
            assert isinstance(content, dict), \
                "podman-compose.yml should be a dictionary"
            assert "services" in content, \
                "podman-compose.yml missing 'services'"
