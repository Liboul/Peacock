require_relative './base'

module Components
  class Speakers < Base

    SOUNDS_DIRECTORY = '/sounds'

    def pin_numbers
      []
    end

    ## Core instructions

    def play_sound(filename:)
      `omxplayer #{File.join(SOUNDS_DIRECTORY, filename)} -o local`
    end

    def parse_instruction(instruction)
      case instruction['command']
      when 'play_sound'
        [core_command_duration_to_timestamp(build_instruction_args(instruction, ['filename']))]
      else
        raise NotImplemtedError.new("This command '#{instruction['command']}' is not available")
      end
    end
  end
end
