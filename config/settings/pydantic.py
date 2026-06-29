from __future__ import annotations

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class AppSettings(BaseSettings):
    """Typed application configuration."""

    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=False,
        extra="ignore",
    )

    secret_key: str = Field(alias="DJANGO_SECRET_KEY")

    debug: bool = Field(alias="DJANGO_DEBUG")

    allowed_hosts: str = Field(alias="DJANGO_ALLOWED_HOSTS")

    postgres_db: str = Field(alias="POSTGRES_DB")

    postgres_user: str = Field(alias="POSTGRES_USER")

    postgres_password: str = Field(alias="POSTGRES_PASSWORD")

    postgres_host: str = Field(alias="POSTGRES_HOST")

    postgres_port: int = Field(alias="POSTGRES_PORT")


settings = AppSettings()
