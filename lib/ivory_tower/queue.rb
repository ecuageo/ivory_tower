require 'json'
class IvoryTower::Queue
  attr_reader :name

  def initialize(name)
    @bunny_queue = IvoryTower::BunnyFactory.queue name
  end

  def consume(&block)
    bunny_queue.subscribe subscribe_options do |delivery_info, properties, body|
      message = Hashie::Mash.new(JSON.parse(body))
      block.call(message)
      channel.ack delivery_info.delivery_tag
    end
  ensure
    close_connection if subscribe_options[:block]
  end

  def produce(message)
    bunny_queue.publish(message.to_json)
    close_connection
  end

  def size
    bunny_queue.message_count
  end

  def subscribe_options=(changes)
    subscribe_options.merge!(changes)
  end

  def empty!
    bunny_queue.purge
  end

  def open?
    connection.status == :open
  end

  def close_connection
    unless connection.status == :closed
      connection.close
    end
  end

  private

  def subscribe_options
    @subscribe_options ||= {manual_ack: true, block: true}
  end

  def bunny_queue
    @bunny_queue
  end

  def channel
    @bunny_queue.channel
  end

  def connection
    channel.connection
  end
end
