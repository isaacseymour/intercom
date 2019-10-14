# frozen_string_literal: true

require 'json'

User = Value.new(:id, :name, :location) do
  def self.parse(string)
    hash = JSON.parse(string).transform_keys(&:to_sym)

    location = SpherePoint.with(
      hash.slice(:latitude, :longitude).transform_values(&:to_f)
    )

    with(
      id: hash.fetch(:user_id),
      name: hash.fetch(:name),
      location: location
    )
  end
end
