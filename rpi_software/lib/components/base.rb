require 'active_support/all'
require 'pry'

module Components
  class Base

    attr_reader :core_instructions
    attr_reader :duration

    def parse_instruction(instruction)
      raise NotImplementedError
    end

    # @param instructions [Array<Hash>] instructions as provided by the client
    # @return [self] for chaining
    def set_instructions(instructions)
      @core_instructions = []
      @duration = 0
      instructions.each do |instruction|
        @core_instructions += parse_instruction(instruction)
      end
      self
    end

    # Adds an instruction
    def core_command_duration_to_timestamp(instruction)
      core_instruction_spec = instruction.dup
      core_instruction_spec['timestamp'] = @duration
      @duration += core_instruction_spec.delete('duration').to_i
      core_instruction_spec
    end

    # Releases all the pins that have been reserved
    def release_pins
      pin_numbers.each do |pin|
        File.open('/sys/class/gpio/unexport', 'w') {|f| f.write("#{pin}")}
      end
    end

    def execute_instructions

    end

    def has_remaining_instructions?
      @core_instructions.present?
    end

    # @param elapsed_time [Float] in milliseconds
    def has_to_execute_instruction?(elapsed_time)
      return false if @core_instructions.blank?
      @core_instructions.first['timestamp'] <= elapsed_time
    end

    def execute_waiting_instruction
      instruction_def = @core_instructions.shift
      send(instruction_def['command'])
    end
  end
end
