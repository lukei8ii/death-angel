class Event < Chingu::GameObject
  attr_reader :name, :text, :count, :instinct, :spawns, :movement, :genestealer_type

  def to_s
    "#{name}, Spawns: #{spawns}"
  end
end