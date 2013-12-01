class CombatTeam < Chingu::GameObject
  traits :bounding_box, :collision_detection

  attr_reader :type
  attr_accessor :selected

  TYPE = %i(red blue yellow green purple gray)

  def initialize(options = {})
    super
    @type = options[:type] || :red
    @image = Gosu::Image["#{@type.to_s}.png"]
  end

  def draw
    super
    $window.draw_rect(self.bounding_box, DeathAngel::SELECTED_COLOR, zorder + 1) if selected
  end

  def name
    type.to_s.capitalize
  end
end