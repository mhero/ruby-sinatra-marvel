class StorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :attribution_text
end