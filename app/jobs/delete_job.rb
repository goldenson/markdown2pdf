class DeleteJob < ApplicationJob
  queue_as :default

  def perform(data)
    ImageUploader::Attacher.delete(data)
  end
end
