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

  def free_seats
    seats.count(false)
  end

  def occupied_seats
    seats.count(true)
  end

  def take_seat(num = nil)
    index = num ? seat_free?(num) : seats.index(false)
    seats[index] = true if index
  end

  def seat_free?(num)
    seats[num - 1] == true
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
end
