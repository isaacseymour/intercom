# frozen_string_literal: true

RSpec.describe User do
  let(:fixture) do
    File.read(File.join(File.dirname(__FILE__), 'fixtures', 'user.json'))
  end

  it 'parses it from JSON' do
    expect(described_class.parse(fixture)).to have_attributes(
      location: have_attributes(latitude: 52.986375, longitude: -6.043701),
      id: 12,
      name: 'Christina McArdle'
    )
  end
end
