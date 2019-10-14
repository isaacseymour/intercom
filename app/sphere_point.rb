# frozen_string_literal: true

require 'values'

SpherePoint = Value.new(:latitude, :longitude) do
  def latitude_radians
    degrees_to_rad(latitude)
  end

  def longitude_radians
    degrees_to_rad(longitude)
  end

  private

  def degrees_to_rad(degrees)
    degrees * Math::PI / 180
  end
end
