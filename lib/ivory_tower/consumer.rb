module IvoryTower::Consumer
  include IvoryTower::Queueable
  
  def run
    queue.messages do |message|
      self.consume(message)
    end
  end
end
