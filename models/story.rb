class Story
  attr_accessor :id, :title, :description, :attribution_text

  def initialize(attributes)
    self.id = attributes[:id]
    self.title = attributes[:title]
    self.description = attributes[:description]
    self.attribution_text = attributes[:attribution_text]
  end
end
