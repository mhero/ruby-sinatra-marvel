class Character
  attr_accessor :id, :name, :description, :story_count, :thumbnail, :attribution_text

  def initialize(attributes)
    self.id = attributes[:id]
    self.name = attributes[:name]
    self.description = attributes[:description]
    self.story_count = attributes[:stories][:available]
    self.thumbnail = ThumbnailHelper.thumbnail_url(attributes[:thumbnail])
    self.attribution_text = attributes[:attribution_text]
  end
end
