require "bunny"

# Start a communication with RabbitMQ
conn = Bunny.new
conn.start

# Open a channel
ch = conn.create_channel

# Create an exchange
x  = ch.fanout("live_cricket")

# Create a random queue
q  = ch.queue("", exclusive: true)

q.bind(x)

puts "India vs Australia cricket match and India is palying..."
puts "To exit, press CTRL+C"

begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts body
  end
rescue Interrupt => _
  ch.close
  conn.close
end
