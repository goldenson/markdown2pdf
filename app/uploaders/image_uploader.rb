class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :determine_mime_type
  plugin :validation_helpers
  plugin :backgrounding
  plugin :processing
  plugin :versions

  # Validations
  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/gif image/png]
    validate_max_size 2.megabytes, message: 'is too large (max is 2 MB)'
  end

  # Processing
  process(:store) do |io, context|
    size_800 = resize_to_limit(io.download, 800, 800)
    size_500 = resize_to_limit(size_800, 500, 500)
    size_300 = resize_to_limit(size_500, 300, 300)

    { large: size_800, medium: size_500, small: size_300 }
  end

  # Background
  Attacher.promote { |data| PromoteJob.set(wait: 5.seconds).perform_later(data) }
  Attacher.delete { |data| DeleteJob.perform_later(data) }
end
