require 'spec_helper'

describe IvoryTower::Queue do
  describe "#messages" do
    let(:mock_queue) { double(:queue) }

    before :each do
      mock_bunny = double(:bunny)
      mock_channel = double(:channel)

      expect(Bunny).to receive(:new).and_return(mock_bunny)
      expect(mock_bunny).to receive(:start)
      expect(mock_bunny).to receive(:create_channel).and_return(mock_channel)
      expect(mock_channel).to receive(:queue).with('Modulus').and_return(mock_queue)
    end

    it "messages wraps rabbit subscribe" do
      queue = IvoryTower::Queue.new "Modulus"

      expect(mock_queue).to receive(:subscribe)

      queue.messages do |message|
        expect(message).to eq nil
      end
    end
  end
end
