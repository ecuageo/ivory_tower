module IvoryTower::Consumer
  
  def run
    queue.messages do |message|
      self.consume(message)
    end
  end

  private

  def queue_name
    self.class.name 
  end

  def queue
    @queue ||= IvoryTower::Queue.new queue_name
  end
end
