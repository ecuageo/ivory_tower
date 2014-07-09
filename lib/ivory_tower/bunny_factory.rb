class IvoryTower::BunnyFactory

  def self.queue(name)
    connection = Bunny.new ENV['CLOUDAMQP_URL']
    connection.start
    channel = connection.create_channel
    channel.queue(name)
  end
end
