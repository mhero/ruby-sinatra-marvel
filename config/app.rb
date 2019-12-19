require "sinatra"
require "sinatra/base"

Dir[File.join("controllers", "**/*_controller.rb")].each { |file| require File.expand_path(file) }
