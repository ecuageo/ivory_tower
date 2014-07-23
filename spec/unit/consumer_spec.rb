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
      expect(mock_queue).to receive(:consume).and_yield({factors: [2,4]})

      mult.run

      expect($multiply_result).to eq 8
    end
  end

  describe "#job_id" do
    it "supplies a unique id for every job" do
      mult = MultiplyConsumer.new
      expect(mult.job_id).to_not eq nil
      expect(mult.job_id).to_not eq ""
      expect(mult.job_id).to_not eq(MultiplyConsumer.new.job_id)
    end
  end
end
