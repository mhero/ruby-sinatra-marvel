class MarvelClient
  def initialize
    @connetion = MarvelHttp.new
  end
  
  def character_by_name(name)
    results = @connetion.fetch("characters", name: name)
    Character.new(results[:results].first)
  end

  def character_stories(character_id, limit = 10, offset = 0)
    results = @connetion.fetch("characters/#{character_id}/stories",offset: offset, limit: limit)
    results[:results].map do |story|
      Story.new(story)
    end
  end
end