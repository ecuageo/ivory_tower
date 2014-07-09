require 'spec_helper'

class AdditionProducer
  include IvoryTower::Producer

end

$starting_value = 0

class AdditionConsumer
  include IvoryTower::Consumer

  def consume(message)
    $starting_value = message["addends"].first + message["addends"].last
  end
end

describe 'Sending a message' do
  let(:addition_consumer) { AdditionConsumer.new }

  it 'pushes a message onto the queue' do
    p = AdditionProducer.new
    queue = IvoryTower::Queue.new "Addition"
    expect {
      p.publish(addends: [1,3])
    }.to change { queue.message_count }.by(1)
  end

  it 'changing global through the queue' do
    addition_consumer.run

    p = AdditionProducer.new
    p.publish(addends: [1,3])

    expect($starting_value).to eq 4
  end
end
