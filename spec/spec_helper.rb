$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'ivory_tower'

FakeQueue = Struct.new(:channel, :close)
FakeChannel = Struct.new(:connection)
FakeConnection = Struct.new(:status, :close)

def mock_queue
  FakeQueue.new(FakeChannel.new(FakeConnection.new(:open, nil)), nil)
end

RSpec.configure do |config|
end
