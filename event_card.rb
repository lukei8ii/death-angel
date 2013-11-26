class EventCard
  attr_reader :name, :text, :count, :instinct, :spawns, :movement, :genestealer_type

  def initialize
    @count = 1
  end
end