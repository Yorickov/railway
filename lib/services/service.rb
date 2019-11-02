class Service
  protected

  def input_index(array)
    array.each.with_index(1) { |item, index| puts "\t#{index}. #{item}" }

    choice = gets.chomp.to_i - 1
    choice.between?(0, array.size - 1) ? choice : input_index(array)
  end
end
