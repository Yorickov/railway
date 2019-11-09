require_relative '../modules/validation'

class CargoCarriage < Carriage
  include Validation

  VOLUME_FORMAT = /^[1-9]{1}[0-9]*$/i.freeze

  attr_reader :max_volume

  validate :max_volume, :format, VOLUME_FORMAT

  def initialize(max_volume)
    @max_volume = max_volume

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

    if amount.to_i.zero?
      puts 'input integer > 0'
      return
    end

    unless take_volume(amount.to_i)
      puts 'no space, sorry'
      return
    end

    puts "Process successfully finished, #{info}"
  end

  # to private after test edit
  def take_volume(amount)
    return unless volume_free?(amount)

    @occupied_volume += amount
  end

  def info
    "No #{number}, type: #{type}, " \
    "volume: free - #{free_volume}, occupied: #{occupied_volume}"
  end

  private

  attr_reader :occupied_volume

  def free_volume
    @max_volume.to_i - @occupied_volume
  end

  def volume_free?(amount)
    amount <= free_volume
  end
end
