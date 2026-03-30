See PROJECT.md for project description.

## Stack

- Ruby 3.4.8, Rails 8
- SQLite
- Minitest
- Rubocop (standard)

## Key commands

- `bin/rails server` — запуск сервера
- `bin/rails test` — тесты
- `bin/rails db:migrate` — миграции

## Conventions

- Придерживаться простоты и Rails-way, за исключением:
    - валидации вне моделей
    - бизнес-логика в service objects (app/services/)
- Rubocop со стандартными правилами
- Код и комментарии на английском

## Constraints

- Не добавлять гемы без явного запроса
- Не менять структуру БД без явного запроса
- Не трогать файлы вне scope текущей задачи
