class Program

  MAX_EVENT_LOOP_TIME = 5 * 60 * 1000
  REFRESH_RATE = 10.0
  MIN_SLEEP = 1.0

  def initialize
    @components = []
  end

  def add_component(component)
    @components << component
  end

  def duration
    @components.map(&:duration).max
  end

  def has_remaining_core_instructions?
    @components.any?(&:has_remaining_instructions?)
  end

  def run
    begin
      event_loop
      "Components instructions: #{@components.map(&:core_instructions)}"
    ensure
      @components.each(&:release_pins)
    end
  end

  def event_loop
    start_time = Time.current
    while has_remaining_core_instructions? and (Time.current - start_time) < MAX_EVENT_LOOP_TIME
      loop_beginning = Time.current
      @components.each do |component|
        component.execute_waiting_instructions if component.has_to_execute_instruction?((Time.current - start_time) * 1000)
      end
      sleep([MIN_SLEEP, (REFRESH_RATE / 1000) - (Time.current - loop_beginning)].max)
    end
  end
end
