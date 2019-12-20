require "sinatra"
require "sinatra/base"
require "dotenv/load"
require "fast_jsonapi"

Dir[File.join("./", "**/*.rb")]
    .reject {|filename| File.expand_path(filename).include? "spec" }
    .each { |file| require File.expand_path(file) }