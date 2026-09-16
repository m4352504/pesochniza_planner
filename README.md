# Мой план

Статическое приложение для GitHub Pages с доступом по почте через Supabase.

Один раз в Supabase:

1. В `SQL Editor` выполните содержимое `supabase-security.sql`.
2. В `Authentication → URL Configuration` укажите в `Site URL` и `Redirect URLs`:
   `https://m4352504.github.io/pesochniza_planner/`
3. В `Authentication → Providers → Email` оставьте включёнными `Email` и `Confirm email`.

После первой регистрации привяжите старые задачи к своей учётной записи двумя запросами внизу файла `supabase-security.sql`.
