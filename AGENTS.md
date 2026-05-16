# AGENTS.md — web3-scam-domains-lists

Единственный output-артефакт репозитория — `scamsniffer.txt` (список доменов, по одному на строку).
Всё остальное — обвязка для его генерации и публикации.

## Структура

- `scamsniffer-dump.sh` — единственный скрипт, точка входа для всего.
- `scamsniffer.txt` — автогенерируемый файл (~350K строк, не редактировать вручную).
- `.github/workflows/update.yml` — CI: ежедневно в полночь UTC + ручной `workflow_dispatch`.

## Как обновить список вручную

```sh
./scamsniffer-dump.sh
```

Требования: `jq`, `curl`. Скрипт скачивает `domains.json` из upstream (scamsniffer/scam-database), фильтрует валидные домены по regex, сортирует, дедуплицирует, пишет в `scamsniffer.txt`.

## Pre-commit хуки (запускаются при `git commit`)

- `yamllint` — для всех `.yaml`/`.yml` (конфиг: `.yamllint`, line-length=warning)
- `shellcheck` — для `.sh`
- `trailing-whitespace`, `end-of-file-fixer`, `check-added-large-files`

## Коммиты

- Автообновления: `bump-YYYYMMDD` (только `scamsniffer.txt`, бот `GitHub Bot <bot@github.com>`)
- Всё остальное: осмысленный human-формат
- Dependabot: префикс `ci:` для обновлений GitHub Actions

## Что НЕ нужно делать агенту

- Редактировать `scamsniffer.txt` напрямую — изменения сметутся при следующем `bump-*`.
- Менять `scamsniffer-dump.sh` без понимания upstream-формата `domains.json`.
- Запускать `pre-commit install` или трогать `git config` — в CI это не требуется.
