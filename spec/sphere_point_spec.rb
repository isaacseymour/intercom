# frozen_string_literal: true

RSpec.describe SpherePoint do
  subject(:point) do
    described_class.with(latitude: 51.5258643, longitude: -0.0849004)
  end

  it 'converts degrees to radians' do
    # Results here taken from Googling degrees-to-radians.
    # Ruby seems to be slightly more precise.
    expect(point.latitude_radians).to be_within(1e-10).of(0.8992959819686)
    expect(point.longitude_radians).to be_within(1e-10).of(-0.00148179151626)
  end
end