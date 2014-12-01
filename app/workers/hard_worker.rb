class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    Rails.logger.info("SIDEKIQ TEST")
  end
end
