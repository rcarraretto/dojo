defmodule SpaceAge do
  @ratio %{
    :mercury => 0.2408467,
    :venus => 0.61519726,
    :earth => 1,
    :mars => 1.8808158,
    :jupiter => 11.862615,
    :saturn => 29.447498,
    :uranus => 84.016846,
    :neptune => 164.79132,
  }
  @earth_seconds 31557600

  def age_on(planet, seconds), do: seconds / (@earth_seconds * @ratio[planet])
end
