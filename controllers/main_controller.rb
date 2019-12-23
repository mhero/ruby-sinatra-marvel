class MainController < Sinatra::Base
  before do
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
  end
  
  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS,POST'
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  end

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
    if response.is_a? Array
      serializer.new(
        response,
        meta: { total: response.count }
      ).serialized_json
    else
      status response
    end
  end
end