-- Vivid Flow schema. Run in Supabase SQL Editor.
-- Replace admin@example.com with your exact Supabase Auth email before running.
create extension if not exists pgcrypto;
create table if not exists public.projects(
 id uuid primary key default gen_random_uuid(), title text not null, category text not null default 'Video Editing',
 description text not null default '', media_type text not null check(media_type in ('image','video')),
 media_url text not null, thumbnail_url text, year text, sort_order integer not null default 0,
 published boolean not null default false, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.site_settings(
 id integer primary key check(id=1), profile_image_url text, cover_image_url text, contact_email text, updated_at timestamptz not null default now()
);
alter table public.projects enable row level security;
alter table public.site_settings enable row level security;
drop policy if exists "Public can view published projects" on public.projects;
create policy "Public can view published projects" on public.projects for select to anon,authenticated using(published=true);
drop policy if exists "Admin can manage projects" on public.projects;
create policy "Admin can manage projects" on public.projects for all to authenticated using((auth.jwt()->>'email')='admin@example.com') with check((auth.jwt()->>'email')='admin@example.com');
drop policy if exists "Public can read site settings" on public.site_settings;
create policy "Public can read site settings" on public.site_settings for select to anon,authenticated using(true);
drop policy if exists "Admin can manage site settings" on public.site_settings;
create policy "Admin can manage site settings" on public.site_settings for all to authenticated using((auth.jwt()->>'email')='admin@example.com') with check((auth.jwt()->>'email')='admin@example.com');
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types) values('portfolio-media','portfolio-media',true,157286400,array['image/jpeg','image/png','image/webp','image/gif','image/avif','video/mp4','video/webm','video/quicktime']) on conflict(id) do update set public=true,file_size_limit=157286400,allowed_mime_types=excluded.allowed_mime_types;
drop policy if exists "Admin can upload portfolio media" on storage.objects;
create policy "Admin can upload portfolio media" on storage.objects for insert to authenticated with check(bucket_id='portfolio-media' and (auth.jwt()->>'email')='admin@example.com' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "Admin can update own portfolio media" on storage.objects;
create policy "Admin can update own portfolio media" on storage.objects for update to authenticated using(bucket_id='portfolio-media' and (auth.jwt()->>'email')='admin@example.com' and (storage.foldername(name))[1]=auth.uid()::text) with check(bucket_id='portfolio-media' and (auth.jwt()->>'email')='admin@example.com' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "Admin can delete own portfolio media" on storage.objects;
create policy "Admin can delete own portfolio media" on storage.objects for delete to authenticated using(bucket_id='portfolio-media' and (auth.jwt()->>'email')='admin@example.com' and (storage.foldername(name))[1]=auth.uid()::text);
