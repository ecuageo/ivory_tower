require 'spec_helper'

describe IvoryTower::Queue do
  let(:mock_queue) { double(:queue) }
  let(:mock_bunny) { double(:bunny) }
  let(:mock_channel) { double(:channel) }

  before :each do
    expect(Bunny).to receive(:new).and_return(mock_bunny)
    expect(mock_bunny).to receive(:start)
    expect(mock_bunny).to receive(:create_channel).and_return(mock_channel)
    expect(mock_channel).to receive(:queue).with('Modulus').and_return(mock_queue)
  end

  describe "#messages" do
    it "messages wraps rabbit subscribe" do
      queue = IvoryTower::Queue.new "Modulus"

      expect(mock_queue).to receive(:subscribe)

      queue.messages do |message|
        expect(message).to eq nil
      end
    end
  end

  describe "#publish" do
    it "delegates to the rabbit queue" do
      message = {operands: [4, 2]}
      expect(mock_queue).to receive(:publish).with(message.to_json)

      queue = IvoryTower::Queue.new "Modulus"
      queue.publish(message)
    end
  end
end
