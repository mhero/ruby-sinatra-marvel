class MainController < Sinatra::Base
  get "/" do
    CharacterSerializer.new(
      MarvelClient.new.character_by_name("hulk")
    ).serialized_json
  end
end
