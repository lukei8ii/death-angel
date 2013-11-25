class SetupLocation < Location
  attr_reader :name, :terrain, :left_blip, :right_blip, :major_spawn, :minor_spawn, :player_count, :location_setup
  def initialize
    @name = 'Void Lock'
  end
end