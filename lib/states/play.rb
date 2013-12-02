class Play < Chingu::GameState
  def initialize(options = {})
    super
    @teams = options[:teams]
  end

  def setup
    @cards = CardLibrary.new(File.join(ROOT_PATH, "cards"))

    # Set up the game board
    @players = [Player.new(@teams)]
    @player_one = @players[0]
    @setup_location = @location = @cards.setup_locations.select { |loc| loc.player_count.include? @players.size }.first

    # Set up blip piles from the setup location
    @blip = {}
    @blip[:left] = @cards.genestealers.take @location.left_blip
    @blip[:right] = @cards.genestealers.take @location.right_blip

    # Draw the first event card
    @event = @cards.events.first

    # Move space marines into the formation
    marines = @cards.space_marines.select do |m|
      @player_one.combat_teams.include? m.team
    end
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

    # Move terrain into the formation
    @location.terrain.each do |loc_t|
      terrain = @cards.terrain.select { |t| loc_t[:type] == t.type }.first
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

      # Move genestealers into the formation
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

    puts "Player 1's combat teams: #{@player_one.combat_teams}"
    puts "Setup location: #{@setup_location}"
    puts "Initial Event: #{@event}"
    puts "Left blip pile: #{@blip[:left].size} cards"
    puts "Right blip pile: #{@blip[:right].size} cards"
    puts "Formation: #{@formation}"

    SpaceMarine.create_from_object @cards.space_marines[2]

    # @testing = SpaceMarine.create(type: :whatever, range: 2, team: :blue)
  end

  def update

  end

  # def draw
  #   super
  #   @testing.draw
  # end
end