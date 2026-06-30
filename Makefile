.PHONY: \
	help up down restart build rebuild logs ps \
	run shell migrate makemigrations superuser check collectstatic \
	test lint format fix \
	install update clean

help:
	@echo ""
	@echo "========== Grocery Store =========="
	@echo ""
	@echo "Development"
	@echo "  make install         Install dependencies"
	@echo "  make update          Update dependencies"
	@echo "  make run             Run Django server"
	@echo "  make shell           Django shell"
	@echo ""
	@echo "Database"
	@echo "  make migrate"
	@echo "  make makemigrations"
	@echo "  make superuser"
	@echo ""
	@echo "Docker"
	@echo "  make up"
	@echo "  make down"
	@echo "  make restart"
	@echo "  make rebuild"
	@echo "  make build"
	@echo "  make logs"
	@echo "  make ps"
	@echo ""
	@echo "Quality"
	@echo "  make check"
	@echo "  make lint"
	@echo "  make format"
	@echo "  make fix"
	@echo "  make test"
	@echo ""
	@echo "Maintenance"
	@echo "  make clean"
	@echo ""

install:
	uv sync

update:
	uv sync --upgrade

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

build:
	docker compose build

rebuild:
	docker compose down
	docker compose build --no-cache
	docker compose up -d

logs:
	docker compose logs -f

ps:
	docker compose ps

run:
	uv run python manage.py runserver

shell:
	uv run python manage.py shell

migrate:
	uv run python manage.py migrate

makemigrations:
	uv run python manage.py makemigrations

superuser:
	uv run python manage.py createsuperuser

collectstatic:
	uv run python manage.py collectstatic --noinput

check:
	uv run python manage.py check

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .

fix:
	uv run ruff check . --fix

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	