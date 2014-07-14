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
    allow_any_instance_of(IvoryTower::Queue).to receive(:subscribe_options).and_return(manual_ack: true, block: false)
    allow_any_instance_of(IvoryTower::Queue).to receive(:close)
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
    AdditionConsumer.new.run

    p = AdditionProducer.new
    p.produce(addends: [1,3])

    sleep 0.25
    expect($addition_value).to eq 4
  end
end

describe 'running the consumer' do
  # is this necessary? won't the ensure block catch this?
  it 'answers to stop' do
    consumer = AdditionConsumer.new
    t = Thread.new do
      consumer.run
    end
    connection = consumer.send(:queue).send(:channel).connection
    expect(connection).to receive(:close).and_call_original
    consumer.stop
  end
end
