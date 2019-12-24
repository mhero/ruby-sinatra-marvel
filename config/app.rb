require "sinatra"
require "sinatra/base"
require "dotenv/load"
require "fast_jsonapi"
require "logger"

$logger = Logger.new(STDOUT)

Dir[File.join("./", "**/*.rb")]
    .reject {|filename| File.expand_path(filename).include? "spec" }
    .reject {|filename| File.expand_path(filename).include? "coverage" }
    .reject {|filename| File.expand_path(filename).include? "react" }
    .each { |file| require File.expand_path(file) }