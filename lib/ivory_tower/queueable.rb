module IvoryTower::Queueable

  protected

  def queue_name
    self.class.name.sub(/Consumer|Producer/, '') 
  end

  def queue
    @queue ||= IvoryTower::Queue.new queue_name
  end
end
