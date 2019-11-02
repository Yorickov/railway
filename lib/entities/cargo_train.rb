class CargoTrain < Train
  def type
    'cargo'
  end

  def valid_carriage?(carriage)
    carriage.class == CargoCarriage
  end
end
