# Vivid Flow Cinematic Portfolio + Admin Studio

## Included
- Animated responsive public portfolio (`index.html`)
- Project gallery and category filters (`site.js`)
- Admin login and project editor (`admin.html`, `admin.js`)
- Image/video upload, thumbnail, categories, edit/delete, publish/unpublish
- Admin site settings for profile image, cover image and contact email
- Supabase database/storage SQL starter (`schema.sql`)

## Required setup before publishing
1. Create a project at https://supabase.com/dashboard.
2. In Project Settings → API, copy Project URL and publishable/anon key into `config.js` (`supabaseUrl`, `supabaseAnonKey`). Never use the `service_role` key in frontend code.
3. Create an admin user in Supabase Authentication → Users. Use a strong password.
4. In `schema.sql`, replace every `admin@example.com` with that exact admin email. Run the SQL in Supabase SQL Editor.
5. Upload the CONTENTS of this folder to your GitHub Portfolio repository root (not the zip itself), replacing old site files, and commit.
6. Visit `https://YOUR-USERNAME.github.io/Portfolio/admin.html` and log in.

## Limitations to address before production
- This is a starter and must be configured and tested against your own Supabase project before use.
- The settings page saves profile and cover image URLs, but those fields still need to be connected to the public homepage to dynamically replace the hero/profile visuals.
- Project record deletion does not yet remove its uploaded storage objects.
- The storage bucket is public so public portfolio assets can be viewed without signing in. Do not upload private media.
- Main upload UI limit is 150 MB; thumbnails/settings images are limited to 15 MB. Use optimized web exports or a dedicated video host for larger videos.
- SQL policy is restricted to the one configured admin email. Keep account access private, and never share your admin password.
