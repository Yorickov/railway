require_relative '../modules/company'
require_relative '../modules/accessors'

class Carriage
  include Company
  include Accessors

  attr_accessor :number

  def self.types
    { passenger: PassengerCarriage, cargo: CargoCarriage }
  end
end
