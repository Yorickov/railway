require_relative '../modules/validation'

class CargoTrain < Train
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :uniqueness, self

  def type
    'cargo'
  end

  private

  def valid_carriage?(carriage)
    carriage.class == CargoCarriage
  end
end
