require 'bundler'

Bundler.require(:default, :development, :production)

env = ENV['RACK_ENV'] ||= 'development'
db_options = YAML.load(File.read('./config/database.yml'))[env]

ActiveRecord::Base.establish_connection(db_options)
