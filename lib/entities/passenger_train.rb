require_relative '../modules/validation'

class PassengerTrain < Train
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :uniqueness, self

  def type
    'passenger'
  end

  private

  def valid_carriage?(carriage)
    carriage.class == PassengerCarriage
  end
end
