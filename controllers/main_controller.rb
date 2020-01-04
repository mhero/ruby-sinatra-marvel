class MainController < AppController
  get "/character" do
    response = Marvel::Client.new.character_by_name(params[:name])
    response_serializer(response, CharacterSerializer)
  end

  get "/character/:id/stories" do |character_id|
    response = Marvel::Client.new.character_stories(
      character_id,
      limit: params[:limit],
      offset: params[:offset]
    )
    response_serializer(response, StorySerializer)
  end

  get "/story/:id/characters" do |story_id|
    response = Marvel::Client.new.story_characters(story_id)
    response_serializer(response, CharacterSerializer)
  end

  private

  def response_serializer(response, serializer)
    return status response.code if response.is_a? Fault
    serializer.new(
      response,
      meta: { total: response.count }
    ).serialized_json
  end
end