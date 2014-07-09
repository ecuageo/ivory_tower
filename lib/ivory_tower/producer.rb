module IvoryTower::Producer
  include IvoryTower::Queueable

  def publish(message)
    queue.publish(message)
  end
end
