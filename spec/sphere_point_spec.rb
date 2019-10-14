# frozen_string_literal: true

RSpec.describe SpherePoint do
  subject(:point) do
    described_class.with(latitude: 51.5258643, longitude: -0.0849004)
  end
  let(:other_point) do
    described_class.with(latitude: 51.526042, longitude: -0.0914257)
  end

  it 'converts degrees to radians' do
    # Results here taken from Googling degrees-to-radians.
    # Ruby seems to be slightly more precise.
    expect(point.latitude_radians).to be_within(1e-10).of(0.8992959819686)
    expect(point.longitude_radians).to be_within(1e-10).of(-0.00148179151626)
  end

  it 'calculates the central angle' do
    # Result here taken from
    # https://www.vcalc.com/wiki/MichaelBartmess/Great+Circle+Central+Angle
    expect(point.central_angle(other_point))
      .to be_within(1e-10).of(0.0000709243930982)
  end

  it 'calculates the distance in km' do
    expect(point.distance(other_point, radius: 100))
      .to be_within(1e-10).of(0.00709243930982)
  end

  london = [51.5258643, -0.0849004]
  dublin = [53.339428, -6.257664]
  sf = [37.788802, -122.4025067]
  [
    [*london, *london, 0],
    [*london, *dublin, 464],
    [*london, *sf, 8614],
    [*dublin, *sf, 8175]
  ]
    .each do |(lat1, lng1, lat2, lng2, distance)|
    specify do
      point1 = described_class.with(latitude: lat1, longitude: lng1)
      point2 = described_class.with(latitude: lat2, longitude: lng2)
      expect(point1.distance(point2, radius: 6371)).to be_within(1).of(distance)
      expect(point2.distance(point1, radius: 6371)).to be_within(1).of(distance)
    end
  end
end
