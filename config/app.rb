require "sinatra"
require "sinatra/base"
require "dotenv/load"

Dir[File.join("controllers", "**/*_controller.rb")].each { |file| require File.expand_path(file) }
Dir[File.join("services", "**/*.rb")].each { |file| require File.expand_path(file) }
