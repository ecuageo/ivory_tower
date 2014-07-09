require 'spec_helper'

describe IvoryTower::Queue do
  let(:mock_queue) { double(:queue) }

  before :each do
    expect(IvoryTower::BunnyFactory).to receive(:queue).and_return(mock_queue)
  end

  describe "#consume" do
    it "consume wraps rabbit subscribe" do
      queue = IvoryTower::Queue.new "Modulus"

      expect(mock_queue).to receive(:subscribe)

      queue.consume do |message|
        expect(message).to eq nil
      end
    end
  end

  describe "#publish" do
    it "delegates to the rabbit queue" do
      message = {operands: [4, 2]}
      expect(mock_queue).to receive(:publish).with(message.to_json)

      queue = IvoryTower::Queue.new "Modulus"
      queue.produce(message)
    end
  end
end
