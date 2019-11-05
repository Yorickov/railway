class Service
  protected

  def input_index(array, name)
    puts "enter index of #{name} or X to exit"

    array.each.with_index(1) { |item, index| puts "\t#{index}. #{item}" }
    choice = gets.chomp
    return if choice.downcase == 'x'

    index = choice.to_i - 1
    index.between?(0, array.size - 1) ? index : input_index(array, name)
  end
end
