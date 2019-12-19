class MainController < Sinatra::Base
  get "/" do
    results = MarvelHttp.new.fetch("characters", name: "hulk")
    results[:data][:results].to_json
  end
end
