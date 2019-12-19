class CharacterSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :story_count, :thumbnail
end