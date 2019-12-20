class ThumbnailHelper
  PORTRAIT = "portrait".freeze
  STANDARD = "standard".freeze
  FANTASTIC = "fantastic".freeze
  INCREDIBLE = "incredible".freeze

  class << self
    def thumbnail_url(thumbnail_data, variant = STANDARD, size = FANTASTIC)
      "#{thumbnail_data.fetch(:path)}/#{variant}_#{size}.#{thumbnail_data.fetch(:extension)}"
    end
  end
end
