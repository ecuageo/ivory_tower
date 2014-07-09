require 'json'
class IvoryTower::Queue
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def messages(&block)
    bunny_queue.subscribe manual_ack: true do |delivery_info, properties, body|
      message = JSON.parse body
      block.call(message)
      channel.ack delivery_info.delivery_tag
    end
  end

  def publish(message)
    bunny_queue.publish(message.to_json)
  end

  def message_count
    bunny_queue.message_count
  end

  private

  def bunny_queue
    @bunny_queue ||= channel.queue(name)
  end

  def channel
    @channel ||= connection.create_channel
  end

  def connection
    unless @connection
      @connection = Bunny.new ENV['CLOUDAMQP_URL']
      @connection.start
    end
    @connection
  end
end
