class CargoTrain < Train
  def type
    'cargo'
  end

  private

  def valid_carriage?(carriage)
    carriage.class == CargoCarriage
  end
end
