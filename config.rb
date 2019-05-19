require 'hanami/model'
require 'hanami/model/sql'
require 'hanami/model/migrator'
require 'hanami/validations'
require 'httparty'
require 'awesome_print'

Dir['./lib/**/*.rb'].each { |file| require file }

Hanami::Model.configure do
  adapter :sql, "postgres://postgres:1@localhost/hj_task_#{ENV['STAGE']}"
  migrations './db/migrations'
  schema 'db/schema.sql'
end.tap do |db_config|
  Hanami::Model::Migrator.prepare
end.load!

PopulateCampaigns.execute if ENV['STAGE'] == 'development'
