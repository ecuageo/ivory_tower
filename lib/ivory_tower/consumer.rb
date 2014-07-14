module IvoryTower::Consumer
  include IvoryTower::Queueable
  
  def run
    queue.consume do |message|
      consume(message)
    end
  end

  def stop
    queue.close
  end
end
