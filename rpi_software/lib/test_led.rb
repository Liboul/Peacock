require 'pi_piper'

class TestLed
  class << self
    include PiPiper

    def call(pin)
      gpio_pin = PiPiper::Pin.new(:pin => pin.to_i, :direction => :out)
      gpio_pin.on
      sleep(2)
      gpio_pin.off
      File.open('/sys/class/gpio/unexport', 'w') {|f| f.write("#{pin.to_i}")}
    end
  end
end
