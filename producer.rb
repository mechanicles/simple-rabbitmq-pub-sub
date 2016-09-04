require "bunny"

# Start a communication with RabbitMQ
conn = Bunny.new
conn.start

# Open a channel
ch = conn.create_channel

# Create an exchange
x =  ch.fanout("live_cricket")

puts "To exit, press CTRL+C"

player = 1
total_run = 0
msg = ""

loop do
  result = [1,2,3,4,6, "out"].sample

  if player < 11
    if result != "out"
      total_run += result
      msg = "India got #{result} run more. Total Run: #{total_run}"
    else
      msg = "OUT! Indian palyer #{player} is out"
      player += 1
    end
    sleep 1.0
    puts msg
    x.publish(msg)
  else
    break
  end
end

conn.close
