require 'yaml'

class CardLibrary
  attr_reader :events, :locations, :space_marines, :action_cards, :brood_lords, :terrain, :setup_locations, :genestealers

  def initialize(card_path)
    # Initialize event deck
    event_prototypes = YAML.load_file "#{card_path}/events.yml"
    @events = []
    event_prototypes.each do |e|
      count = e.count || 1
      count.times { @events << e }
    end
    @events.shuffle

    # Initialize location deck
    @locations = YAML.load_file "#{card_path}/locations.yml"

    # Initialize combat teams
    combat_team_cards = YAML.load_file "#{card_path}/marines.yml"
    @space_marines = combat_team_cards[:space_marines]
    @action_cards = combat_team_cards[:action_cards]

    # Initialize brood lords, terrain cards, and setup locations
    misc = YAML.load_file "#{card_path}/misc.yml"
    @brood_lords = misc[:brood_lords].shuffle
    @terrain = misc[:terrain]
    @setup_locations = misc[:setup_locations]

    # Initialize genestealear deck
    genestealer_prototypes = misc[:genestealers].shuffle
    @genestealers = []
    genestealer_prototypes.each { |g| g.count.times { @genestealers << g } }
    @genestealers.shuffle!
  end
end