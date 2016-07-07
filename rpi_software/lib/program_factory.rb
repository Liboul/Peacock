require 'active_support/all'
require 'yaml'
require 'pry'

require_relative './program'
require_relative './components/led_group'

class ProgramFactory

  DEVICE_CONFIG_PATH = 'device_config.yml'

  # @param instructions [Hash] containing all the parameters
  def self.call(instructions)
    program = Program.new
    instructions.each do |component_name, instructions_arr|
      program.add_component(instantiate_component(component_name).set_instructions(instructions_arr))
    end
    program.run
  end

  # @param component_name [String]
  # @return [Component]
  def self.instantiate_component(component_name)
    unless device_config.include? component_name
      raise StandardError.new("Component #{component_name} is not supported. Check your device_config.yml")
    end
    component_class = "Components::#{device_config[component_name]['class']}".constantize
    component_class.new(device_config[component_name]['args'].symbolize_keys)
  end

  # @return [Hash] containing the whole configuration
  def self.device_config
    return @device_config if @device_config
    File.open(DEVICE_CONFIG_PATH, 'r') do |f|
      @device_config = YAML::load(f.read)
    end
  end
end
