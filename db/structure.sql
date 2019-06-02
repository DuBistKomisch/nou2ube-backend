CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "roles" ("id" integer NOT NULL PRIMARY KEY, "name" varchar, "resource_id" integer, "resource_type" varchar, "created_at" datetime, "updated_at" datetime);
CREATE TABLE IF NOT EXISTS "users_roles" ("user_id" integer, "role_id" integer);
CREATE UNIQUE INDEX "index_roles_on_id" ON "roles" ("id");
CREATE UNIQUE INDEX "index_roles_on_name" ON "roles" ("name");
CREATE INDEX "index_roles_on_name_and_resource_type_and_resource_id" ON "roles" ("name", "resource_type", "resource_id");
CREATE UNIQUE INDEX "index_users_roles_on_user_id_and_role_id" ON "users_roles" ("user_id", "role_id");
CREATE TABLE IF NOT EXISTS "channels" ("id" integer NOT NULL PRIMARY KEY, "api_id" varchar NOT NULL, "title" varchar NOT NULL, "thumbnail" varchar NOT NULL, "uploads_id" varchar DEFAULT '' NOT NULL, "checked_at" datetime NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "secret_key" varchar DEFAULT '' NOT NULL);
CREATE UNIQUE INDEX "index_channels_on_id" ON "channels" ("id");
CREATE UNIQUE INDEX "index_channels_on_api_id" ON "channels" ("api_id");
CREATE TABLE IF NOT EXISTS "videos" ("id" integer NOT NULL PRIMARY KEY, "api_id" varchar NOT NULL, "channel_id" integer NOT NULL, "title" varchar NOT NULL, "thumbnail" varchar NOT NULL, "duration" integer DEFAULT 0 NOT NULL, "published_at" datetime NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_videos_on_id" ON "videos" ("id");
CREATE UNIQUE INDEX "index_videos_on_api_id" ON "videos" ("api_id");
CREATE INDEX "index_videos_on_channel_id" ON "videos" ("channel_id");
CREATE TABLE IF NOT EXISTS "subscriptions" ("id" integer NOT NULL PRIMARY KEY, "user_id" integer NOT NULL, "channel_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_subscriptions_on_id" ON "subscriptions" ("id");
CREATE INDEX "index_subscriptions_on_user_id" ON "subscriptions" ("user_id");
CREATE INDEX "index_subscriptions_on_channel_id" ON "subscriptions" ("channel_id");
CREATE UNIQUE INDEX "index_subscriptions_on_user_id_and_channel_id" ON "subscriptions" ("user_id", "channel_id");
CREATE TABLE IF NOT EXISTS "items" ("id" integer NOT NULL PRIMARY KEY, "subscription_id" integer NOT NULL, "video_id" integer NOT NULL, "state" integer DEFAULT 0 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_items_on_id" ON "items" ("id");
CREATE INDEX "index_items_on_subscription_id" ON "items" ("subscription_id");
CREATE INDEX "index_items_on_video_id" ON "items" ("video_id");
CREATE TABLE IF NOT EXISTS "users" ("id" integer NOT NULL PRIMARY KEY, "email" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "authentication_token" varchar NOT NULL, "refresh_token" varchar NOT NULL);
CREATE UNIQUE INDEX "index_users_on_id" ON "users" ("id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
INSERT INTO "schema_migrations" (version) VALUES
('20160815161102'),
('20160815161420'),
('20160815172635'),
('20160815181345'),
('20160815181908'),
('20160815182423'),
('20160815184158'),
('20160817162932'),
('20160817173237'),
('20170401020551'),
('20190602061347'),
('20190602102525');


