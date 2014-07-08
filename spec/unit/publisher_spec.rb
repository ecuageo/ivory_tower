require 'spec_helper'

class SubtractionPublisher
  include IvoryTower::Publisher
end

describe IvoryTower::Publisher do
  describe "#publish" do
    it "takes a message" do
      sub = SubtractionPublisher.new
      expect { sub.publish(:message) }.to_not raise_error
    end
  end
end
