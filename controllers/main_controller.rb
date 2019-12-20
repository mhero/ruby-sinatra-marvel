class MainController < Sinatra::Base
  get "/character" do
    CharacterSerializer.new(
      MarvelClient.new.character_by_name(params[:name])
    ).serialized_json
  end

  get "/character/:id/stories" do |character_id|
    response = MarvelClient.new.character_stories(
      character_id,
      limit: params[:limit],
      offset: params[:offset]
    )

    StorySerializer.new(
      response,
      meta: { total: response.count }
    ).serialized_json
  end

  get "/story/:id/characters" do |story_id|
    response = MarvelClient.new.story_characters(story_id)

    CharacterSerializer.new(
      response,
      meta: { total: response.count }
    ).serialized_json
  end
end