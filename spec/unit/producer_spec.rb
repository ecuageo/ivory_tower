require 'spec_helper'

class SubtractionProducer
  include IvoryTower::Producer
end

describe IvoryTower::Producer do
  describe "#produce" do
    it "produces to the correct queue" do
      sub = SubtractionProducer.new

      mock_queue = double(:queue)
      expect(IvoryTower::Queue).to receive(:new).with("Subtraction").and_return(mock_queue)
      expect(mock_queue).to receive(:produce).with(:message)

      sub.produce(:message)
    end
  end
end
