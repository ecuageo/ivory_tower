require 'spec_helper'

describe IvoryTower::BunnyFactory do
  let(:mock_bunny) { double(:bunny) }
  let(:mock_channel) { double(:channel) }
  let(:mock_queue) { double(:queue) }

  before :each do
    expect(Bunny).to receive(:new).and_return(mock_bunny)
    expect(mock_bunny).to receive(:start)
    expect(mock_bunny).to receive(:create_channel).and_return(mock_channel)
    expect(mock_channel).to receive(:queue).with('Modulus').and_return(mock_queue)
  end

  describe ".queue" do
    it "queue grabs a bunny queue" do
      queue = IvoryTower::BunnyFactory.queue "Modulus"
      expect(queue).to eq mock_queue
    end
  end
end
