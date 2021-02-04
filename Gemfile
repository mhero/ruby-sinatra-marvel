if File.exists?("Gemfile.tip")
  eval_gemfile File.join(File.dirname(__FILE__), "Gemfile.tip")
end

source "https://rubygems.org" do
  gem "dotenv"
  gem "sinatra"
  gem "faraday"
  gem "fast_jsonapi"
  gem "logger"
  gem "faraday_middleware"
  gem "rack-cache"
  gem "require_all"

  group :test, :development do
    gem "rack-test"
    gem "rspec"
    gem "webmock"
    gem "vcr"
    gem "rerun"
    gem "simplecov", require: false
  end
end
