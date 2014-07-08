require 'spec_helper'

# class AdditionQueue
#   def get_message(msg)
#   end
# end

class AdditionPublisher
  include IvoryTower::Publisher

end

$starting_value = 0

class AdditionConsumer
  include IvoryTower::Consumer

  def consume(message)
    $starting_value = 4
  end
end

describe 'Sending a message' do
  let(:addition_consumer) { AdditionConsumer.new }

  it 'notifies publishes a message onto a queue' do
    addition_consumer.run

    p = AdditionPublisher.new
    p.publish(addends: [1,3])

    expect($starting_value).to eq 4
  end
end
