class MainController < Sinatra::Base
  get "/" do
    c = MarvelClient.new.character_by_name("hulk")
    CharacterSerializer.new(c).serialized_json

    b = MarvelClient.new.character_stories(c.id)
    options = {}
    options[:meta] = { total: b.count }
    StorySerializer.new(b, options).serialized_json

    d = MarvelClient.new.story_characters(b.first.id)
    options = {}
    options[:meta] = { total: d.count }
    CharacterSerializer.new(d, options).serialized_json
  end
end
