CREATE TABLE `schema_migrations` (`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `campaigns` (`id` integer NOT NULL PRIMARY KEY AUTOINCREMENT, `job_id` varchar(255) NOT NULL, `status` varchar(255) NOT NULL, `external_reference` varchar(255) NOT NULL, `ad_description` varchar(255) NOT NULL);
INSERT INTO "schema_migrations" VALUES('20190519225049_create_campaigns.rb');