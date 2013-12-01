class SpaceMarine < Chingu::GameObject
  attr_reader :type, :range, :team

  def name
    type.titleize
  end
end