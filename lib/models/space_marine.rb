class SpaceMarine < EnhancedGameObject
  attr_accessor :type, :range, :team

  def initialize(options={})
    super
    @image = Gosu::Image["#{@team.to_s}.png"]
    @label = Chingu::Text.create(text: name, x: @x, y: @y, size: 20)

    # disable until needed
    hide!
    pause!
    @label.hide!
    @label.pause!
  end

  def name
    type.to_s.capitalize
  end
end