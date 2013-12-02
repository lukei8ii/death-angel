class Event < EnhancedGameObject
  attr_accessor :name, :text, :count, :instinct, :spawns, :movement, :genestealer_type

  def to_s
    "#{name}, Spawns: #{spawns}"
  end
end