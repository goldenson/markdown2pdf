class LoggerJob < ApplicationJob
  queue_as :default

  def perform(post)
    Rails.logger.warn "[Post] #{post}"
  end
end
