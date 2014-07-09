require 'json'
class IvoryTower::Queue
  attr_reader :name

  def initialize(name)
    @bunny_queue = IvoryTower::BunnyFactory.queue name
  end

  def consume(&block)
    bunny_queue.subscribe manual_ack: true do |delivery_info, properties, body|
      message = JSON.parse body
      block.call(message)
      channel.ack delivery_info.delivery_tag
    end
  end

  def produce(message)
    bunny_queue.publish(message.to_json)
  end

  def size
    bunny_queue.message_count
  end

  def empty!
    bunny_queue.purge
  end

  private

  def bunny_queue
    @bunny_queue
  end

  def channel
    @bunny_queue.channel
  end
end
