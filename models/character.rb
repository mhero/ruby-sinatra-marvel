class Character
  attr_accessor :id, :name, :description, :story_count, :thumbnail

  def initialize(attributes)
    self.id = attributes[:id]
    self.name = attributes[:name]
    self.description = attributes[:description]
    self.story_count = attributes[:stories][:available]
    self.thumbnail = attributes[:thumbnail]
  end
end
