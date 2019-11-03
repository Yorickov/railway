require_relative '../modules/company'

class Carriage
  include Company

  def self.types
    { passenger: PassengerCarriage, cargo: CargoCarriage }
  end
end
