# frozen_string_literal: true

RSpec.describe User do
  let(:fixture_path) do
    File.join(File.dirname(__FILE__), 'fixtures', 'users.json')
  end
  let(:fixture) { File.open(fixture_path) }
  let(:line) { fixture.lines.first }

  describe '.parse' do
    it 'parses it from JSON' do
      expect(described_class.parse(line)).to have_attributes(
        location: have_attributes(latitude: 52.986375, longitude: -6.043701),
        id: 12,
        name: 'Christina McArdle'
      )
    end
  end

  describe '.parse_all' do
    it 'parses all the lines' do
      result = described_class.parse_all(fixture)
      expect(result.count).to eq(32)
    end
  end
end
