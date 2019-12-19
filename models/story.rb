class Story
  attr_accessor :id, :title, :description

  def initialize(attributes)
    self.id = attributes[:id]
    self.title = attributes[:title]
    self.description = attributes[:description]
  end
end
