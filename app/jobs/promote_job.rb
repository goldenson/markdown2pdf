class PromoteJob < ApplicationJob
  queue_as :default

  def perform(data)
    ImageUploader::Attacher.promote(data)
  end
end
