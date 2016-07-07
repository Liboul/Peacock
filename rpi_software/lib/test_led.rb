require 'pi_piper'

class TestLed
  include PiPiper

  def self.call(pin)
    watch :pin => pin do
      puts "Pin changed from #{last_value} to #{value}"
    end

    pin = PiPiper::Pin.new(:pin => pin, :direction => :out)
    pin.on
    pin.sleep(5)
    pin.off
  end
end
