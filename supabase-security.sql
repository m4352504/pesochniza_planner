-- Выполните этот скрипт в Supabase: SQL Editor → New query → Run.
-- Он переводит задачи на доступ только владельцу, вошедшему по почте.

alter table public.tasks add column if not exists user_id uuid references auth.users(id) on delete cascade;
alter table public.task_comments add column if not exists user_id uuid references auth.users(id) on delete cascade;

alter table public.tasks enable row level security;
alter table public.task_comments enable row level security;

drop policy if exists "Public board tasks" on public.tasks;
drop policy if exists "Public board comments" on public.task_comments;
drop policy if exists "Users manage own tasks" on public.tasks;
drop policy if exists "Users manage own comments" on public.task_comments;

create policy "Users manage own tasks" on public.tasks
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "Users manage own comments" on public.task_comments
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- ВАЖНО: старые задачи, созданные до регистрации, нужно один раз привязать
-- к своей учётной записи. После регистрации выполните отдельно, подставив свой UUID:
-- update public.tasks set user_id = 'ВАШ_UUID' where user_id is null;
-- update public.task_comments set user_id = 'ВАШ_UUID' where user_id is null;
