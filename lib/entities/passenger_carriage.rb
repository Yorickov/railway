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
    puts 'input seat number, 0 if seat is not important or X to exit'

    seat = gets.chomp
    return if seat.downcase == 'x'

    # if seat == '0'
    #   puts 'no space, sorry' unless take_seat
    #   return
    # end

    unless seat.to_i
      puts 'input integer'
      return
    end

    arg = seat == '0' ? nil : seat.to_i
    puts 'no space, sorry' unless take_seat(arg)
  end

  def take_seat(num = nil) # to private after test edit
    index = num ? seat_free?(num) : seats.index(false)
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
    seats[num - 1] == true
  end

  def free_seats
    seats.count(false)
  end

  def occupied_seats
    seats.count(true)
  end
end
