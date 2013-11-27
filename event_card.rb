class EventCard
  attr_reader :name, :text, :count, :instinct, :spawns, :movement, :genestealer_type
  def self.from_yaml(yaml)
    event = YAML::load(yaml)
    event.count = 1
    event
  end

  def to_s
    "#{name}, Spawns: #{spawns}"
  end
end