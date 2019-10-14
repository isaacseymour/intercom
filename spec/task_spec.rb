# frozen_string_literal: true

RSpec.describe Task do
  let(:dublin) { SpherePoint.with(latitude: 53.339428, longitude: -6.257664) }

  it 'filters by distance' do
    task = described_class.with(
      radius: 6371,
      central_point: dublin,
      max_distance: 100
    )

    path = File.join(File.dirname(__FILE__), 'fixtures', 'users.json')
    result = task.call(File.open(path))

    expect(result.count).to eq(16)
  end
end
