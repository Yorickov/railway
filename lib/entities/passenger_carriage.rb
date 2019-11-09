require_relative '../modules/validation'

class PassengerCarriage < Carriage
  include Validation

  SEAT_COUNT_FORMAT = /^[1-9]{1}[0-9]*$/i.freeze

  attr_reader :seat_count, :seats

  validate :seat_count, :format, SEAT_COUNT_FORMAT

  def initialize(seat_count)
    @seat_count = seat_count
    validate!

    @seats = Array.new(@seat_count.to_i) { false }
  end

  def type
    'passenger'
  end

  def load
    puts 'input seat number (integer), A to take any place or X to exit'

    seat = gets.chomp
    return if seat.downcase == 'x'

    if seat.to_i.zero? && seat.downcase != 'a'
      puts 'input integer > 0 or A'
      return
    end

    arg = seat.downcase == 'a' ? nil : seat.to_i

    unless take_seat(arg)
      puts 'no space, sorry'
      return
    end

    puts "Process successfully finished, #{info}"
  end

  # to private after test edit
  def take_seat(num = nil)
    index = num ? seat_free?(num) && (num - 1) : seats.index(false)
    seats[index] = true if index
  end

  def info
    "No #{number}, type: #{type}, " \
    "seats: free - #{free_seats}, occupied: #{occupied_seats}"
  end

  private

  def seat_free?(num)
    seats[num - 1] == false
  end

  def free_seats
    seats.count(false)
  end

  def occupied_seats
    seats.count(true)
  end
end
