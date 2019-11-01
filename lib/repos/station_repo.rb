class StationRepo < Repo
  def stations_list
    data.map(&:name)
  end
end
