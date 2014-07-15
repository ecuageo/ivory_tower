require 'spec_helper'

class AdditionProducer
  include IvoryTower::Producer
end

$addition_value = 0

class AdditionConsumer
  include IvoryTower::Consumer

  def consume(message)
    $addition_value = message["addends"].first + message["addends"].last
  end
end

describe 'Sending a message' do
  before :each do
    allow_any_instance_of(IvoryTower::Queue).to receive(:close_connection)
  end

  after :each do
    queue = IvoryTower::Queue.new "Addition"
    queue.empty!
    queue.send(:channel).connection.close
  end

  it 'pushes a message onto the queue' do
    queue = IvoryTower::Queue.new "Addition"
    p = AdditionProducer.new
    expect {
      p.produce(addends: [1,3])
    }.to change { queue.size }.by(1)
  end

  it 'changes global through the queue' do
    AdditionConsumer.new.run({block: false})

    p = AdditionProducer.new
    p.produce(addends: [1,3])

    sleep 0.25
    expect($addition_value).to eq 4
  end
end
