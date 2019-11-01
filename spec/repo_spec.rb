require 'station'
require 'repos/repo'
require 'repos/station_repo'

describe Repo do
  it 'all in' do
    repo = StationRepo.new
    station = Station.new('Boston')

    repo.save(station)
    expect(repo.find_by_index(0).name).to eq('Boston')
  end
end
