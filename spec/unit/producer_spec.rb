require 'spec_helper'

class SubtractionProducer
  include IvoryTower::Producer
end

describe IvoryTower::Producer do
  describe "#publish" do
    it "publishes to the correct queue" do
      sub = SubtractionProducer.new

      mock_queue = double(:queue)
      expect(IvoryTower::Queue).to receive(:new).with("Subtraction").and_return(mock_queue)
      expect(mock_queue).to receive(:publish).with(:message)

      sub.publish(:message)
    end
  end
end
