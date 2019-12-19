require "sinatra"
require "sinatra/base"
require "dotenv/load"

Dir[File.join("./", "**/*.rb")].each { |file| require File.expand_path(file) }