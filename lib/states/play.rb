class Play < Chingu::GameState
  def initialize(options = {})
    super
    @teams = options[:teams]
  end

  def setup
    @background = Chingu::GameObject.create(x: $window.width / 2, y: $window.height / 2, image: Gosu::Image["space_hulk2.jpg"])

    @cards = CardLibrary.new(File.join(ROOT_PATH, "cards"))

    # Set up the game board
    @players = [Player.new(@teams)]
    @player_one = @players[0]

    margin_x = margin_y = 20
    starting_y = DeathAngel::CARD_HEIGHT + margin_y
    middle_x = $window.width / 2

    setup_location_y = DeathAngel::CARD_HEIGHT / 2 + margin_y
    @setup_location = @location = @cards.setup_locations.select { |loc| loc.player_count.include? @players.size }.first
    @setup_location.x = @setup_location.label.x = middle_x
    @setup_location.y = @setup_location.label.y = setup_location_y

    @setup_location.show!
    @setup_location.label.show!

    # Set up blip piles from the setup location
    @blip = {}
    @blip[:left] = @cards.genestealers.slice! 0, @location.left_blip
    @blip[:right] = @cards.genestealers.slice! 0, @location.right_blip

    # Draw the first event card
    @event = @cards.events.slice! 0

    # Move space marines into the formation
    marines = @cards.space_marines.select do |m|
      @player_one.combat_teams.include? m.team
    end

    @formation = []
    marines.shuffle.each_with_index.map do |marine, i|
      marine.x = marine.label.x = middle_x
      marine.y = marine.label.y = get_y_formation(i, margin_y, starting_y)
      marine.show!
      marine.label.show!

      facing = i < marines.size / 2 ? :left : :right
      marine.label.text = facing == :left ? "< #{marine.label.text}" : "#{marine.label.text} >"

      @formation << {
        marine_position: {
          marine: marine,
          facing: facing
        },
        terrain_position: {},
        swarm: {}
      }
    end

    # Move terrain into the formation
    terrain_offset = DeathAngel::CARD_WIDTH + margin_x
    terrain_x = {}
    terrain_x[:left] = middle_x - terrain_offset
    terrain_x[:right] = middle_x + terrain_offset
    spawn_x = {}
    spawn_x[:left] = terrain_x[:left] - terrain_offset
    spawn_x[:right] = terrain_x[:right] + terrain_offset

    @location.terrain.each do |loc_t|
      terrain = @cards.terrain.select { |t| loc_t[:type] == t.type }.first
      side = loc_t[:side]

      index = 0
      if loc_t[:from] == :top
        index = loc_t[:position]
      else
        index = @formation.size - 1 - loc_t[:position]
      end

      terrain.x = terrain.label.x = terrain_x[side]
      spawn_y = terrain_y = get_y_formation(index, margin_y, starting_y)
      terrain.y = terrain.label.y = terrain_y

      # [:x, :y, :zorder, :angle, :center_x, :center_y, :factor_x, :factor_y, :severity, :mode].each do |a|
      #   puts "terrain.#{a}: #{terrain.send(a)}"
      # end

      terrain.show!
      terrain.label.show!

      @formation[index][:terrain_position][side] = { terrain: terrain }

      # Move genestealers into the formation
      spawns = @event.spawns.select { |s| terrain.severity == s[:severity] }

      spawns.each do |s|
        # puts "severity: #{s[:severity]}"
        # puts "terrain: #{terrain.label.text}"
        # puts "spawn #{side} x: #{spawn_x[side]}"
        # puts "spawn #{side} y: #{terrain.y}"

        amount = case s[:type]
                 when :major then @setup_location.major_spawn
                 else @setup_location.minor_spawn
                 end

        genestealers = @blip[side].slice!(0, amount)

        genestealers.each do |g|
          g.x = g.label.x = spawn_x[side]
          g.y = g.label.y = spawn_y
          g.label.text = "#{genestealers.size} #{'Genestealer'.pluralize(genestealers.size)}"

          g.show!
          g.label.show!
        end

        @formation[index][:swarm][side] = genestealers
      end
    end

    [:left, :right].each do |side|
      @blip[side].each do |g|
        g.x = g.label.x = terrain_x[side]
        g.y = g.label.y = setup_location_y
        g.label.text = "#{@blip[side].size} #{'Blip'.pluralize(@blip[side].size)}"

        g.show!
        g.label.show!
      end
    end

    # puts "Player 1's combat teams: #{@player_one.combat_teams}"
    # puts "Setup location: #{@setup_location}"
    # puts "Initial Event: #{@event}"
    # puts "Left blip pile: #{@blip[:left].size} cards"
    # puts "Right blip pile: #{@blip[:right].size} cards"
    # puts "Formation: #{@formation}"

    # SpaceMarine.create_from_object @cards.space_marines[2]

    # @testing = SpaceMarine.create(type: :whatever, range: 2, team: :blue)
  end

  def get_y_formation(row_index, margin, offset)
    (row_index * DeathAngel::CARD_HEIGHT) + ((row_index + 1) * margin) + (DeathAngel::CARD_HEIGHT / 2) + offset
  end

  def update

  end

  # def draw
  #   super
  #   @testing.draw
  # end
end