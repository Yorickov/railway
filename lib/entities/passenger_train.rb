class PassengerTrain < Train
  def type
    'passenger'
  end

  private

  def valid_carriage?(carriage)
    carriage.class == PassengerCarriage
  end
end
