class SpaceMarine
  COMBAT_TEAMS = %i(red blue yellow green purple gray)

  attr_reader :type, :range, :team

  def name
    type.titleize
  end
end