module Marvel  
  class Client
    def initialize
      @connetion = Marvel::Http.new
    end
    
    def character_by_name(name)
      result = @connetion.fetch("characters", name: name)
      result.handle(Character)
    end

    def character_stories(character_id, options = {})
      result = @connetion.fetch(
                  "characters/#{character_id}/stories",
                  limit: sanitize_param(options[:limit], 10),
                  offset: sanitize_param(options[:offset], 0)
                )
      result.handle(Story)
    end

    def story_characters(story_id)
      result = @connetion.fetch("stories/#{story_id}/characters")
      result.handle(Character)
    end

    private

    def sanitize_param(param, default)
      (param || default).to_i
    end
  end
end