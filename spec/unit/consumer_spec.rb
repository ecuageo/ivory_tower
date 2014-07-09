require 'spec_helper'

$multiply_result = nil

class MultiplyConsumer
  include IvoryTower::Consumer

  def consume(message)
    $multiply_result = message[:factors].first * message[:factors].last
  end
end

describe IvoryTower::Consumer do
  describe "#run" do
    it "subscribles to the 'mulitply' queue" do
      mult = MultiplyConsumer.new

      mock_queue = double(:queue)
      expect(IvoryTower::Queue).to receive(:new).with("Multiply").and_return(mock_queue)
      expect(mock_queue).to receive(:messages).and_yield({factors: [2,4]})

      mult.run

      expect($multiply_result).to eq 8
    end
  end
end
