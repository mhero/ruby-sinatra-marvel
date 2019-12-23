require "sinatra"
require "sinatra/base"
require "dotenv/load"
require "fast_jsonapi"
require "logger"
require "simplecov"
SimpleCov.start

$logger = Logger.new(STDOUT)

Dir[File.join("./", "**/*.rb")]
    .reject {|filename| File.expand_path(filename).include? "spec" }
    .each { |file| require File.expand_path(file) }