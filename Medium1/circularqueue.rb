class CircularQueue
  attr_reader :buffer, :max_size

  def initialize(max_size)
    @buffer = Hash.new
    @max_size = max_size
  end

  def enqueue(obj)
    dequeue if buffer.size == max_size
    buffer[Time.new] = obj
  end

  def dequeue
    oldest_key = Time.new
    buffer.each { |key, value| oldest_key = key if oldest_key > key }
    buffer.delete(oldest_key)
  end
end


queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil