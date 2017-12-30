require 'securerandom'

class ApplicationController < ActionController::Base

  def index
    start_time = Time.now.to_f

    delay = params[:delay] || 1500  # Millis
    delay = delay.to_i
    cpu = params[:cpu] || 20
    cpu = cpu.to_i
    file = params[:file] || 20
    file = file.to_i
    memory = params[:memory] || 20
    memory = memory.to_i
    uuid = SecureRandom.uuid

    cpu = 1 if (cpu <= 0)

    memory_array = "a" * (memory * 1000000)

    done = false
    math_result = nil
    while (!done)
      current_time = Time.now.to_f

      # Do some math (for cpu usage)
      math_result = Math.tan(current_time)
      time_remaining = (start_time + (delay / 1000.0)) - current_time

#      puts "Time remaining: #{time_remaining} seconds"
      (1..file).each do |index|
        File.open("/tmp/#{uuid}", 'w') { |file| file.write(uuid * 10000) }
        File.delete("/tmp/#{uuid}")
      end

      if (current_time - start_time > (delay/1000.0))
        done = true
      else
        time_to_sleep = 10.0 / cpu
        if (time_to_sleep > time_remaining)
          time_to_sleep = time_remaining
          done = true
        end
        if (time_to_sleep > 0)
          sleep (time_to_sleep)
        end
      end
    end

    puts "Memory array size = #{memory_array.length}  Math result: #{math_result}"

    render :json => {
          host: `hostname`.strip,
          delay: delay,
          cpu: cpu,
          memory: memory,
          timestamp: "#{Time.now}",
          uuid: uuid
        }
  end

end
