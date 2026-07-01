from pathlib import Path


def test_project_structure() -> None:
    """Ensure the repository has the expected structure."""

    assert Path("manage.py").exists()
    assert Path("pyproject.toml").exists()
