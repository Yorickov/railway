class PassengerTrain < Train
  def type
    'passenger'
  end

  def valid_carriage?(carriage)
    carriage.class == PassengerCarriage
  end
end
