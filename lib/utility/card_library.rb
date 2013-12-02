require 'yaml'

class CardLibrary
  attr_reader :events, :locations, :space_marines, :action_cards, :brood_lords, :terrain, :setup_locations, :genestealers

  def initialize(card_path)
    # Initialize event deck
    event_data = YAML.load_file "#{card_path}/events.yml"
    @events = []
    event_data.each { |e| e[:count].times { @events << Event.create(e) } }
    @events.shuffle!

    # Initialize location deck
    location_data = YAML.load_file "#{card_path}/locations.yml"
    @locations = location_data.map { |l| Location.create(l) }

    # Initialize combat teams
    combat_team_data = YAML.load_file "#{card_path}/marines.yml"
    @space_marines = combat_team_data[:space_marines].map { |sm| SpaceMarine.create(sm.merge(factor_x: DeathAngel::CARD_SCALE, factor_y: DeathAngel::CARD_SCALE)) }
    @actions = combat_team_data[:actions].map { |a| Action.create(a) }

    # Initialize brood lords, terrain cards, and setup locations
    misc_data = YAML.load_file "#{card_path}/misc.yml"
    @brood_lords = misc_data[:brood_lords].map { |b| BroodLord.create(b) }.shuffle!
    @terrain = misc_data[:terrain].map { |t| Terrain.create(t.merge(factor_x: DeathAngel::CARD_SCALE, factor_y: DeathAngel::CARD_SCALE)) }
    @setup_locations = misc_data[:setup_locations].map { |sl| SetupLocation.create(sl) }

    # Initialize genestealear deck
    genestealer_prototypes = misc_data[:genestealers]
    @genestealers = []
    genestealer_prototypes.each { |g| g[:count].times { @genestealers << Genestealer.create(g) } }
    @genestealers.shuffle!
  end
end