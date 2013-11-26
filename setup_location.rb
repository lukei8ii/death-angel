class SetupLocation < Location
  attr_reader :name, :terrain, :left_blip, :right_blip, :major_spawn, :minor_spawn, :player_count, :location_setup

  def to_s
    "#{name}, Setup for #{player_count.join(' or ')} #{player_count.size > 1 ? 'players' : 'player'}, Location Deck Setup: #{location_setup.join(' > ')}"
  end
end