# frozen_string_literal: true

require 'values'

SpherePoint = Value.new(:latitude, :longitude) do
  def latitude_radians
    degrees_to_rad(latitude)
  end

  def longitude_radians
    degrees_to_rad(longitude)
  end

  def central_angle(other)
    # https://en.wikipedia.org/wiki/Great-circle_distance#Formulae
    # Using the basic formula - I hope you're on a 64-bit CPU!
    Math.acos(
      sin_latitudes(other) +
      (cos_latitudes(other) * cos_longitude_diff(other))
    )
  end

  private

  def sin_latitudes(other)
    Math.sin(latitude_radians) * Math.sin(other.latitude_radians)
  end

  def cos_latitudes(other)
    Math.cos(latitude_radians) * Math.cos(other.latitude_radians)
  end

  def cos_longitude_diff(other)
    Math.cos((longitude_radians - other.longitude_radians).abs)
  end

  def degrees_to_rad(degrees)
    degrees * Math::PI / 180
  end
end
