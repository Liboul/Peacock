require 'pi_piper'

require_relative './base'

module Components
  class LedGroup < Base

    attr_reader :core_instructions

    def initialize(pin_number:)
      @pin_number = pin_number.to_i
      @core_instructions = []
    end

    def pin_numbers
      [@pin_number]
    end

    # Gives access to the pin
    def pin
      @pin ||= PiPiper::Pin.new(:pin => pin.to_i, :direction => :out)
    end

    ## Core instructions

    def turn_on
      pin.on
    end

    def turn_off
      pin.off
    end

    ## Other instructions

    def blink(duration, frequency)
    end

    # @param instruction [Hash]
    def parse_instruction(instruction)
      case instruction['command']
      when 'turn_on', 'turn_off'
        [core_command_duration_to_timestamp(instruction)]
      when 'blink'
        []
      else
        raise NotImplemtedError.new('This command is not available')
      end
    end
  end
end
