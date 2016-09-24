class ImageUploader < Shrine
  # plugins and uploading logic
  plugin :backgrounding
  Attacher.promote { |data| PromoteJob.set(wait: 5.seconds).perform_later(data) }
  Attacher.delete { |data| DeleteJob.perform_later(data) }
end
