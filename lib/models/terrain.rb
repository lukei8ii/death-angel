class Terrain < EnhancedGameObject
  attr_accessor :type, :severity, :activate
  attr_accessor :label

  def initialize(options={})
    super
    @image = Gosu::Image["terrain.png"].clone
    @label = Chingu::Text.create(text: "#{@type.to_s.titleize}: #{@severity.to_s.titleize}", x: @x, y: @y, size: 20)
    @label.center = 0.5
    @label.color = Gosu::Color::BLACK

    # disable until needed
    hide!
    pause!
    @label.hide!
    @label.pause!
  end
end