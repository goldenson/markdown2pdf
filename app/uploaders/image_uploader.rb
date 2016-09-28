class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :validation_helpers
  plugin :backgrounding

  # Validations
  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/gif image/png]
    validate_max_size 2.megabytes, message: 'is too large (max is 2 MB)'
  end

  # Background
  Attacher.promote { |data| PromoteJob.set(wait: 5.seconds).perform_later(data) }
  Attacher.delete { |data| DeleteJob.perform_later(data) }
end
