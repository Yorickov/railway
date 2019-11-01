class TrainRepo < Repo
  def trains_list
    data.map(&:id)
  end
end
