require "sinatra"
require "sinatra/base"
require "dotenv/load"
require "fast_jsonapi"

Dir[File.join("./", "**/*.rb")].each { |file| require File.expand_path(file) }