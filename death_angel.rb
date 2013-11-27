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
  WIDTH = 1280
  HEIGHT = 800
  CURSOR_OFFSET = 34
  ASSET_FOLDER = 'assets'

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    # Initialize images
    Dir.chdir(ASSET_FOLDER) do
      asset_names = Dir.glob "*.png"
      @assets = {}
      asset_names.each do |n|
        @assets[n.sub('.png', '').to_sym] = Gosu::Image.new(self, n, true)
      end

      @cursor = Gosu::Image.new(self, "cursor.gif", true)
    end

    # Initialize event deck
    event_prototypes = YAML.load_file('cards_events.yml')
    @events = []
    event_prototypes.each do |e|
      count = e.count || 1
      count.times { @events << e }
    end
    @events.shuffle

    # Initialize location deck
    @locations = YAML.load_file 'cards_locations.yml'

    # Initialize combat teams
    combat_team_cards = YAML.load_file 'cards_marines.yml'
    @space_marines = combat_team_cards[:space_marines]
    @action_cards = combat_team_cards[:action_cards]

    # Initialize brood lords, terrain cards, and setup locations
    misc = YAML.load_file 'cards_misc.yml'
    @brood_lords = misc[:brood_lords].shuffle
    @terrain = misc[:terrain]
    @setup_locations = misc[:setup_locations]

    # Initialize genestealear deck
    genestealer_prototypes = misc[:genestealers].shuffle
    @genestealers = []
    genestealer_prototypes.each { |g| g.count.times { @genestealers << g } }
    @genestealers.shuffle!

    # Set up the game board
    @players = [Player.new]
    @player_one = @players[0]
    @setup_location = @location = @setup_locations.select { |loc| loc.player_count.include? @players.size }.first

    @blip = {}
    @blip[:left] = @genestealers.take @location.left_blip
    @blip[:right] = @genestealers.take @location.right_blip
    @event = @events.first

    marines = @space_marines.select { |m| @player_one.combat_teams.include? m.team }
    @formation = []
    marines.shuffle.each_with_index.map do |marine, i|
      @formation << {
        marine_position: {
          marine: marine,
          facing: i < marines.size / 2 ? :left : :right
        },
        terrain_position: {},
        swarm: {}
      }
    end

    @location.terrain.each do |loc_t|
      terrain = @terrain.select { |t| loc_t[:type] == t.type }.first
      side = loc_t[:side]

      index = 0
      if loc_t[:from] == :top
        index = loc_t[:position]
      else
        index = @formation.size - 1 - loc_t[:position]
      end

      @formation[index][:terrain_position][side] = {
        terrain: terrain
      }

      @event.spawns.each do |s|
        if terrain.color == s[:color]
          amount = case s[:type]
                   when :major then @setup_location.major_spawn
                   else @setup_location.minor_spawn
                   end

          @formation[index][:swarm][side] = @blip[side].slice!(0, amount)
        end
      end
    end

    @font = Gosu::Font.new(self, "Arial", 30)

    puts "Images loaded: #{@assets.keys}"
    puts "Player 1's combat teams: #{@player_one.combat_teams}"
    puts "Setup location: #{@setup_location}"
    puts "Total Events: #{@events.size}"
    puts "Total Genestealers: #{@genestealers.size}"
    puts "Initial Event: #{@event}"
    puts "Left blip pile: #{@blip[:left].size} cards"
    puts "Right blip pile: #{@blip[:right].size} cards"
    puts "Formation: #{@formation}"
  end

  def update

  end

  def draw
    @cursor.draw self.mouse_x - CURSOR_OFFSET, self.mouse_y - CURSOR_OFFSET, 1000
    @font.draw("Choose your combat teams", 470, 30, 0)
    x_margin = 15
    y_margin = 90
    x_scale = y_scale = 0.5

    SpaceMarine::COMBAT_TEAMS.each_with_index do |c, i|
      x_offset = (x_scale * @assets[c].width + x_margin) * i + x_margin
      # y_offset = (y_scale * @assets[c].height + y_margin) * i
      @assets[c].draw x_offset, y_margin, 0, x_scale, y_scale
    end
  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end
end

DeathAngel.run