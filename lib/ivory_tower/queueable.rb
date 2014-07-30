module IvoryTower::Queueable

  protected

  def queue_name
    self.class.name.sub(/Consumer|Producer/, '') 
  end

  def queue
    if @queue
      return @queue if @queue.open?
      @queue.close_connection
    end
    @queue = IvoryTower::Queue.new queue_name
  end
end
