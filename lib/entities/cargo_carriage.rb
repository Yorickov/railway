class CargoCarriage < Carriage
  attr_reader :max_volume

  def initialize(max_volume)
    @max_volume = max_volume.strip.to_i

    validate!
    @occupied_volume = 0
  end

  def type
    'cargo'
  end

  def load
    puts 'input amount to fill the carriage or X to exit'

    amount = gets.chomp
    return if amount.downcase == 'x'

    unless amount.to_i
      puts 'input integer'
      return
    end

    puts 'no space, sorry' unless take_volume(amount.to_i)
    puts "Process successfully finished, #{info}"
  end

  def take_volume(amount) # to private after test edit
    return unless volume_free?(amount)

    @occupied_volume += amount
  end

  def info
    "No #{number}, type: #{type}, " \
    "volume: free - #{free_volume}, occupied: #{occupied_volume}"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  attr_reader :occupied_volume

  def validate!
    raise 'You must input smth.' if max_volume.zero?
    raise 'Should be from 1 to 1000' unless max_volume.between?(1, 1000)
  end

  def free_volume
    @max_volume - @occupied_volume
  end

  def volume_free?(amount)
    amount <= free_volume
  end
end
