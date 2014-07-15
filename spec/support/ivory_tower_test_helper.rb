class IvoryTowerTestHelper
  def self.setup_queue(name, &block)
    queue = IvoryTower::Queue.new name
    queue.empty!
    block.call
    queue.send(:channel).connection.close
  end
end
