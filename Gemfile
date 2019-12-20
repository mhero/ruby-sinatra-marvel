if File.exists?("Gemfile.tip")
  eval_gemfile File.join(File.dirname(__FILE__), "Gemfile.tip")
end

source "https://rubygems.org" do
  gem "dotenv"
  gem "sinatra"
  gem "faraday"
  gem "fast_jsonapi"

  group :test, :development do
    gem "rack-test"
    gem "rspec"
    gem "webmock"
    gem "vcr"
    gem "rerun"
  end
end
