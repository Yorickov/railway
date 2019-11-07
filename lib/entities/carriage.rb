require_relative '../modules/company'

class Carriage
  include Company

  attr_accessor :number

  def self.types
    { passenger: PassengerCarriage, cargo: CargoCarriage }
  end
end
