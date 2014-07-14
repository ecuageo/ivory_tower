require 'spec_helper'

describe IvoryTower::Queue do
  let(:stub_queue) { mock_queue }

  before :each do
    allow(IvoryTower::BunnyFactory).to receive(:queue).and_return(stub_queue)
  end

  describe "#consume" do
    it "consume wraps rabbit subscribe" do
      queue = IvoryTower::Queue.new "Modulus"

      expect(stub_queue).to receive(:subscribe)

      queue.consume do |message|
        expect(message).to eq nil
      end
    end
  end

  describe "#publish" do
    it "delegates to the rabbit queue" do
      message = {operands: [4, 2]}
      expect(stub_queue).to receive(:publish).with(message.to_json)

      queue = IvoryTower::Queue.new "Modulus"
      queue.produce(message)
    end
  end

  describe "#close" do
    it "closes the connection" do
      queue = IvoryTower::Queue.new "Modulus"
      expect(stub_queue.channel.connection).to receive(:close)
      queue.close
    end
  end
end
