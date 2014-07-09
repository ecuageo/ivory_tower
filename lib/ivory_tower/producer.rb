module IvoryTower::Producer
  include IvoryTower::Queueable

  def produce(message)
    queue.produce(message)
  end
end
