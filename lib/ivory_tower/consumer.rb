require 'securerandom'

module IvoryTower::Consumer
  include IvoryTower::Queueable
  
  def run(options = nil)
    queue.subscribe_options = options if options

    queue.consume do |message|
      consume(message)
    end
  end

  def job_id
    @job_id ||= SecureRandom.hex
  end
end
