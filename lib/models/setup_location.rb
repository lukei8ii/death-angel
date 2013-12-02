class SetupLocation < EnhancedGameObject
  attr_accessor :name, :terrain, :left_blip, :right_blip, :major_spawn, :minor_spawn, :player_count, :location_setup

  def to_s
    "#{player_count.join(' or ')} #{player_count.size > 1 ? 'players' : 'player'}, Left: #{@left_blip}, Right: #{@right_blip}, Major: #{@major_spawn}, Minor: #{@minor_spawn}, Location Deck Setup: #{location_setup.join(' > ')}"
  end
end