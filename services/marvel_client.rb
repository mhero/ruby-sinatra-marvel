class MarvelClient
  def initialize
    @connetion = MarvelHttp.new
  end
  
  def character_by_name(name)
    result = @connetion.fetch("characters", name: name)
    if result.success?
      Character.new(result.handle.first)
    end
  end

  def character_stories(character_id, options = {})
    result = @connetion.fetch(
                "characters/#{character_id}/stories",
                limit: sanitize_param(options[:limit], 10),
                offset: sanitize_param(options[:offset], 0)
              )
    if result.success?
      result.handle.map do |story|
        Story.new(story)
      end
    end
  end

  def story_characters(story_id)
    result = @connetion.fetch("stories/#{story_id}/characters")
    if result.success?
      result.handle.map do |character|
        Character.new(character)
      end
    end
  end

  private

  private

  def sanitize_param(param, default)
    (param || default).to_i
  end
end