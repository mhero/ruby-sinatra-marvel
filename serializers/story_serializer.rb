class StorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description
end