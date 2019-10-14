# frozen_string_literal: true

Task = Value.new(:radius, :central_point, :max_distance) do
  def call(io)
    User.parse_all(io)
        .select { |user| distance(user) <= max_distance }
        .sort_by(&:id)
        .map { |user| "#{user.name} (#{user.id})" }
  end

  private

  def distance(user)
    central_point.distance(user.location, radius: radius)
  end
end
