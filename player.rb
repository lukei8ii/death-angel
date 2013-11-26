class Player
  attr_reader :combat_teams
  def initialize(combat_teams = [:red, :blue])
    @combat_teams = combat_teams
  end
end