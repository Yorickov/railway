class TrainRepo < Repo
  def trains_list
    data.map(&:number)
  end
end
