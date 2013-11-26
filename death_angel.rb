require "bundler/setup"
require "hasu"
require "yaml"

%w(
  action_card
  brood_lord
  combat_die
  combat_team_marker
  event_card
  genestealer
  location
  player
  setup_location
  space_marine
  support_token
  terrain
).each do |file|
  Hasu.load "#{file}.rb"
end

class DeathAngel < Hasu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @events = YAML.load_file 'cards_events.yml'
    @locations = YAML.load_file 'cards_locations.yml'
    combat_team_cards = YAML.load_file 'cards_marines.yml'
    @space_marines = combat_team_cards[:space_marines]
    @action_cards = combat_team_cards[:action_cards]
    misc = YAML.load_file 'cards_misc.yml'
    @genestealers = misc[:genestealers]
    @brood_lords = misc[:brood_lords]
    @terrain = misc[:terrain]
    @setup_locations = misc[:setup_locations]

    @players = [Player.new]
    @player_one = @players[0]
    @location = @setup_locations.select { |loc| loc.player_count.include? @players.size }.first
    @left_blip = @location.left_blip
    @right_blip = @location.right_blip
    @formation = @space_marines.select { |m| @player_one.combat_teams.include? m.team }.shuffle

    # @font = Gosu::Font.new(self, "Arial", 30)

    puts "Player 1's combat teams: #{@player_one.combat_teams}"
    puts "Setup location: #{@location}"
    puts "Left blip pile: #{@left_blip} cards"
    puts "Right blip pile: #{@right_blip} cards"
    puts "Formation: #{@formation}"
  end

  def update

  end

  def draw
    # @font.draw(@player.combat_teams, 30, 30, 0)
  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end
end

DeathAngel.run