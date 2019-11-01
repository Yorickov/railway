class Repo
  attr_reader :data

  def initialize
    @data = []
  end

  def save(entity)
    @data << entity
  end

  def find_by_index(index)
    data[index]
  end
end
