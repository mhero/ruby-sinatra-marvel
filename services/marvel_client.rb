class MarvelClient
  def initialize
    @fetcher = MarvelHttp.new
  end
  
  def character_by_name(name)
    results = @fetcher.fetch("characters", name: name)
    Character.new(results[:results].first)
  end
end