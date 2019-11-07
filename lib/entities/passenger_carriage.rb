class PassengerCarriage < Carriage
  attr_reader :seat_count, :seats

  def initialize(seat_count)
    @seat_count = seat_count.strip.to_i
    validate!

    @seats = Array.new(@seat_count) { false }
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

  def take_seat(num = nil) # to private after test edit
    index = num && seat_free?(num) ? (num - 1) : seats.index(false)
    p index
    seats[index] = true if index
  end

  def info
    "No #{number}, type: #{type}, " \
    "seats: free - #{free_seats}, occupied: #{occupied_seats}"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'You must input smth. digitally' if seat_count.zero?
    raise 'Should be from 1 to 100' unless seat_count.between?(1, 100)
  end

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
